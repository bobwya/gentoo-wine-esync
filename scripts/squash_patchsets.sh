#!/bin/env bash

trap "exit 1" TERM
export TOP_PID=$$

declare -r SHA1_REGEXP="[[:xdigit:]]{40}" VARIABLE_NAME_REGEXP="^[_[:alpha:]][_[:alnum:]]+$"

declare SCRIPT_NAME
SCRIPT_NAME="$(readlink -f "${0}")"
SCRIPT_NAME="$(basename "${SCRIPT_NAME}")"

declare PATCHSET_START="0001"
declare PATCHSET_END="0083"
declare PATCHSET_TOTAL="$((10#${PATCHSET_END}-10#${PATCHSET_START}+1))"
declare PATCHFILE_PREFIX="wine-esync"
declare ESYNC_BASE_URL="https://github.com/zfigura/wine/releases/download"
declare ESYNC_VERSION_ARRAY=(
    "esyncb4478b7"
    "esyncce79346"
)
declare ESYNC_SHA256_ARRAY=(
    "2cacc317e07531987c41c5aceb41862b06d4717840916dfc01c11513b359a962"
    "c2a8dd2afc7be4d3ddaf3eeb4c4302e0ea80e1542eb11d6484290de5d36b9a78"
)
declare TARBALL_EXT="tgz"

# download_unpack_esync_patchsets()
#
# Parameters:
#   1>   message-text   :  Error message text         (string)
#   2>   usage-display? :  Display usage message, 1=yes *0=no (boolean)
#                          *default
# Description:
#   An (optional) usage message may be displayed.
#   Display an error message and exit the script.
#
die()
{
	local usage="${2:-0}"

	if ((usage)); then
		printf "Usage: %s WINE-GIT-TREE WINE-STAGING-GIT-TREE SOURCE-ROOT REBASE-PATCHSETS-ROOT DESTINATION-ROOT\\n\\n" "${SCRIPT_NAME}" >&2
		printf "  WINE-GIT-TREE          : Wine git tree clone (root directory)\\n" >&2
		printf "  WINE-STAGING-GIT-TREE  : Wine Staging git tree clone (root directory)\\n" >&2
		printf "  SOURCE-ROOT            : Source wine-esync source(s) (root directory)\\n" >&2
		printf "  REBASE-PATCHSETS-ROOT  : wine-esync rebasing patchsets (root directory)\\n" >&2
		printf "  DESTINATION-ROOT       : Destination for squashed wine-esync rebased patchsets (root directory)\\n" >&2
	fi
	printf "\\n%s : %s : %s\\n" "${SCRIPT_NAME}" "${FUNCNAME[1]}()" "${1}" >&2

	kill -s TERM "${TOP_PID}"
	exit 1
}

# mangle_path()
#
# Parameters:
#   1>   source-path      :  Source path       (string)
#   2<   destination-path :  Destination path  (string, reference)
#
# Description:
#   Mangles the source path, replacing '/' with '-' and '.' with '_'.
#   The target destination path is returned (by reference) with the mangled
#   file path.
#
mangle_path()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	# shellcheck disable=SC2124
	local __source_path="${1}" __path_reference="${2}"
	if [[ ! "${__path_reference}" =~ ${VARIABLE_NAME_REGEXP} ]]; then
		die "invalid parameter reference name (2): '${__path_reference}' (${VARIABLE_NAME_REGEXP})"
	else
		declare -n 	target_path="${__path_reference}"
	fi

	target_path="${__source_path}"
	target_path="${target_path//\//-}"
	target_path="${target_path//./_}"
}

# reset_git_tree()
#
# Parameters:
#   1>    git-tree   :  Git tree root directory  (string)
#   2>    git-commit :  Git commit               (hexidecmial SHA1 hash string)
#
# Description:
#   Resets the git-tree Git directory, to the Git commit hash specified
#   by git-commit.
#
reset_git_tree()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local __git_tree="${1}" __git_commit="${2}" __git_error

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	if ! __git_error="$(git reset --hard "${__git_commit}" >/dev/null)"; then
		printf "%s\\n" "${__git_error}" >&2
		die "git reset failed"
	fi
	popd >/dev/null || die "popd failed"
}

# git_garbage_collect()
#
# Parameters:
#   1>    git-tree   :  Git tree root directory  (string)
#
# Description:
#   Garbage collect the specified Git tree (git-tree) directory.
#
git_garbage_collect()
{
	(($# == 1)) || die "invalid parameter count: ${#} (1)"

	local __git_tree="${1}"

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	git am --abort &>/dev/null
	git gc --auto || die "git gc failed"
	git prune || die "git prune failed"
	rm -f ".git/gc.log" &>/dev/null
	popd >/dev/null || die "popd failed"
}

# git_create_branch()
#
# Parameters:
#   1>    git-tree   :  Git tree root directory  (string)
#   2>    git-branch :  Git branch               (string)
#
# Description:
#   Deletes an existing branch of the same name (git-branch) in
#   the specified Git tree (git-tree). Creates a clean Git branch
#   called git-branch and checks this out.
#
git_create_branch()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local __git_tree="${1}" __git_branch="${2}"

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	if git branch --list | grep -q "${__git_branch}"; then
		git reset --hard HEAD || die "git reset failed"
		git clean -fxd || die "git clean failed"
		git checkout master || die "git checkout failed"
		git branch -D "${__git_branch}" || die "git branch failed"
	fi
	git checkout -b "${__git_branch}" || die "git checkout failed"
	popd >/dev/null || die "popd failed"
}

# git_commit_in_tree()
#
# Parameters:
#   1>    git-tree   :  Git tree root directory  (string)
#   2>    git-commit :  Git commit               (hexidecmial SHA1 hash string)
#   <                :  returns : 0=yes, 1=no
#
# Description:
#   Tests the git-tree Git directory, to determine if the Git commit hash (git-commit)
#   is present in the Git tree.
#
git_commit_in_tree()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local __git_tree="${1}" __git_commit="${2}" __matched=0

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	if git rev-list HEAD | grep -q "${__git_commit}"; then
		__matched=1
	fi
	popd >/dev/null || die "popd failed"
	return $((!__matched))
}

# git_get_commit()
#
# Parameters:
#   1>    git-tree          :  Git tree root directory     (string)
#   2<    git-commit        :  Git commit                  (hexidecmial SHA1 hash string)
#
# Description:
#   Retrieves the current Git commit, for the HEAD in the Git tree
#   (git-tree).
#
git_get_commit()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local __git_tree="${1}" __git_commit_reference="${2}"
	if [[ ! "${__git_commit_reference}" =~ ${VARIABLE_NAME_REGEXP} ]]; then
		die "invalid parameter reference name (2): '${__git_commit_reference}' (${VARIABLE_NAME_REGEXP})"
	else
		declare -n 	git_tag="${__git_commit_reference}"
	fi

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	git_commit="$(git rev-parse HEAD 2>/dev/null)"
	popd >/dev/null || die "popd failed"
	[[ -z "${git_commit}" ]] && die "git tag failed"
}

# git_get_tag()
#
# Parameters:
#   1>    git-tree          :  Git tree root directory     (string)
#   2>    git-commit        :  Git commit                  (hexidecmial SHA1 hash string)
#   3>    git-tag-index     :  Index of Git tag to return  (integer)
#   3<    git-tag-reference :  Git tag                     (string, reference)
#
# Description:
#   Retrieves all the valid Git tags for a commit, version sorts these and
#   returns the specific indexed tag. E.g. where index (git-tag-index) is:
#
#     -n = n(th) preceeding tag
#     ...
#     -1 = previous tag
#      0 = current tag
#      1 = next tag
#     ...
#      n = n(th) following tag
#
#   Ignores tags which do not contain a '.'.
#
git_get_tag()
{
	(($# == 4)) || die "invalid parameter count: ${#} (4)"

	local __git_tree="${1}" __git_commit="${2}" __tag_index="${3}" __git_tag_reference="${4}"
	if [[ ! "${__git_tag_reference}" =~ ${VARIABLE_NAME_REGEXP} ]]; then
		die "invalid parameter reference name (4): '${__git_tag_reference}' (${VARIABLE_NAME_REGEXP})"
	else
		declare -n 	git_tag="${__git_tag_reference}"
	fi

	pushd "${__git_tree}" >/dev/null || die "pushd failed"
	if ((__tag_index > 0)); then
		git_tag="$(git tag --contains "${__git_commit}" 2>/dev/null | grep '[.]' | sort -V | awk -vidx=$((__tag_index)) 'FNR==idx')"
	else
		git_tag="$(git tag --no-contains "${__git_commit}" 2>/dev/null | grep '[.]' | sort -rV | awk -vidx=$((1-__tag_index)) 'FNR==idx')"
	fi
	popd >/dev/null || die "popd failed"
	[[ -z "${git_tag}" ]] && git_tag="origin/master"
}

# convert_wine_to_wine_staging_commit()
#
# Parameters:
#   1>    wine-git-tree           :  Wine Git tree root directory          (string)
#   2>    wine-staging-git-tree   :  Wine Staging Git tree root directory  (string)
#   3<    wine-git-commit         :  Wine Git commit                       (hexidecmial SHA1 hash string, reference)
#   4<    wine-staging-git-commit :  Wine Staging Git commit               (hexidecmial SHA1 hash string, reference)
#
# Description:
#   Initally the Wine Git tree (wine-git-tree) is checked. The currently set Wine Git tag reference
#   is mangled to a Wine Staging Git tag reference. The Wine Staging Git tag reference is then used
#   to set the Wine Staging Git tree base commit (wine-staging-git-tree). Then walk backwards through
#   the Wine Staging Git tree till we find a Staging commit that has an Upstream Wine Git commit,
#   which is matches or predates the originally set Wine Git commit.
#   If match is found then return the:
#      Wine Git commit (wine-git-commit)
#      Wine Staging Git commit (wine-staging-git-commit)
#
convert_wine_to_wine_staging_commit()
{
	(($# == 4)) || die "invalid parameter count: ${#} (4)"

	local 	__wine_git_tree="${1}" \
			__wine_staging_git_tree="${2}" \
			__wine_git_commit_reference="${3}" \
			__wine_staging_git_commit_reference="${4}"
	if [[ ! "${__wine_git_commit_reference}" =~ ${VARIABLE_NAME_REGEXP} ]]; then
		die "invalid parameter reference name (3): '${__wine_git_commit_reference}' (${VARIABLE_NAME_REGEXP})"
	else
		declare -n 	wine_git_commit="${__wine_git_commit_reference}"
	fi
	if [[ ! "${__wine_staging_git_commit_reference}" =~ ${VARIABLE_NAME_REGEXP} ]]; then
		die "invalid parameter reference name (3): '${__wine_staging_git_commit_reference}' (${VARIABLE_NAME_REGEXP})"
	else
		declare -n 	wine_staging_git_commit="${__wine_staging_git_commit_reference}"
	fi
	
	local __current_git_tag __i __next_git_tag __staging_previous_git_tag __staging_next_git_tag __staging_git_commit \
		__match=0 __upstream_git_commit __patch_install_script="${__wine_staging_git_tree}/patches/patchinstall.sh"
	local -a __staging_git_commit_array

	pushd "${__wine_staging_git_tree}" >/dev/null || die "pushd failed"
	git_get_commit "${__wine_git_tree}" wine_git_commit

	# Wine Staging does not build reliably, prior to the version 3.3 release.
	if [[ "${wine_git_commit}" == "a7aa192a78d02d28f2bbae919a3f5c726e4e9e60" ]]; then
		wine_staging_git_commit="9d84ed42f15e778d7de813fae5663eb07b70a2d4"
		wine_git_commit="f9e1dbb83d850a2f7cb17079e02de139e2f8b920"
		popd >/dev/null || die "popd failed"
		return 0
	fi

	# Get a valid current tag for Wine Staging Git tree (working backwards)
	for ((__i=0 ;; --__i)); do
		git_get_tag "${__wine_git_tree}" "${wine_git_commit}" $((__i)) "__current_git_tag"
		__staging_previous_git_tag="${__current_git_tag//wine-/v}"
		git reset --hard "${__staging_previous_git_tag}" &>/dev/null && break
	done

	# Get a valid next tag for Wine Staging Git tree (working forwards)
	for ((__i=1 ;; ++__i)); do
		git_get_tag "${__wine_git_tree}" "${wine_git_commit}" $((__i)) "__next_git_tag"
		__staging_next_git_tag="${__next_git_tag//wine-/v}"
		git reset --hard "${__staging_next_git_tag}" &>/dev/null && break
	done

	printf "\\nSearching within Wine Staging git tag range: '%s'..'%s' " \
		"${__staging_previous_git_tag}" "${__staging_next_git_tag}"
	# shellcheck disable=SC2207
	__staging_git_commit_array=( $(git rev-list "${__staging_previous_git_tag}~1..${__staging_next_git_tag}") )
	for __i in "${!__staging_git_commit_array[@]}"; do
		printf "."
		reset_git_tree "${__wine_staging_git_tree}" "${__staging_git_commit_array[__i]}"
		__upstream_git_commit="$("${__patch_install_script}" --upstream-commit)"
		if ! git_commit_in_tree "${__wine_git_tree}" "${__upstream_git_commit}"; then
			__staging_git_commit="${__staging_git_commit_array[__i]}"
			__wine_git_commit="${__upstream_git_commit}"
		elif [[ -n "${__staging_git_commit}" && -n "${__wine_git_commit}" ]]; then
			# shellcheck disable=SC2034
			wine_staging_git_commit="${__staging_git_commit}"
			wine_git_commit="${__wine_git_commit}"
			__match=1
			break
		fi
	done
	printf "\\n"
	popd >/dev/null || die "popd failed"

	((__match)) || die "unable to locate Wine Staging git commit, correpsonding to Wine git commit: '${wine_git_commit}'"
}

# download_unpack_esync_patchsets()
#
# Parameters:
#   1>   source_directory   :  root directory, in which to unpack esync tarball (string)
#
# Description:
#   Download (if necessary) and esync tarball(s) have valid sha256sum(s).
#   Then unpack all esync tarball(s).
#
function download_unpack_esync_patchsets()
{
	(($# == 1)) || die "invalid number of arguments: $# (1)"

	local _source_directory="${1%/}" \
		_esync_directory _esync_tarball _i

	pushd "${_source_directory}" >/dev/null || die "pushd failed"
	for _i in "${!ESYNC_VERSION_ARRAY[@]}"; do
		_esync_directory="${ESYNC_VERSION_ARRAY[_i]}"
		_esync_tarball="${_esync_directory}.${TARBALL_EXT}"
		if ! sha256sum -c --quiet <<< "${ESYNC_SHA256_ARRAY[_i]} ${_esync_tarball}"; then
			wget "${ESYNC_BASE_URL}/${ESYNC_VERSION_ARRAY[_i]}/esync.${TARBALL_EXT}" -O "${_esync_tarball}" || die "wget failed"
			if ! sha256sum -c --quiet <<< "${ESYNC_SHA256_ARRAY[_i]} ${_esync_tarball}"; then
				die "sha256sum failed on esync tarball: '${_esync_tarball}'"
			fi
		fi
		rm -rf "${_source_directory:?}/${_esync_directory}" \
			|| die "rm -rf '${_source_directory}/${_esync_directory}' failed"
		mkdir -p "${_source_directory:?}/${_esync_directory}" \
			|| die "mkdir -p '${_source_directory}/${_esync_directory}' failed"
		tar xvfa "${_source_directory}/${_esync_tarball}" -C "${_source_directory}/${_esync_directory}" \
			|| die "tar xvfa '${_source_directory}/${_esync_tarball}' -C '${_source_directory}/${_esync_directory}' failed"
	done
	popd >/dev/null || die "popd failed"
}

# apply_esync_rebasing_patchset()
#
# Parameters:
#   1>   source-directory   :  root directory for stock esync patchset source (string)
#   2>   rebasing-patches   :  directory containing esync rebasing patches    (string)
#
# Description:
#   Rebase the esync patchset, in the source-directory, using the rebasing patches, in
#   the rebasing-patches directory. Uses patch to apply the patchses. The patches are
#   not applied in any specific order.
#
apply_esync_rebasing_patchset()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local 	__source_directory="${1}" \
			__rebasing_patches="${2}"
	local 	__patch __patch_file __patch_log

	pushd "${__source_directory}" >/dev/null || die "pushd failed"	
	for __patch in "${__rebasing_patches}"/*.patch; do
		__patch_file="$( basename "${__patch}" )"
		printf "Apply esync rebasing patch: '%s' ...\\n" "${__patch_file}"
		if ! __patch_log="$(patch -p1 --verbose < "${__patch}" )"; then
			printf "%s\\n" "${__patch_log}" >&2
			die "patch -p1 failed, with esync rebasing patch '${__patch}"
		fi
	done
	popd >/dev/null || die "popd failed"
}

# git_am_wine_staging_patchset()
#
# Parameters:
#   1>   wine-git-tree           :  Wine Git tree root directory          (string)
#   2>   wine-staging-git-tree   :  Wine Staging Git tree root directory  (string)
#   3>   wine-git-commit         :  Wine Git commit                       (hexidecmial SHA1 hash string)
#   4>   wine-staging-git-commit :  Wine Staging Git commit               (hexidecmial SHA1 hash string)
#
# Description:
#   Clean up any uncommited changes, in the Wine Git tree (wine-git-tree), initially.
#   Reset the Wine Git tree (wine-git-tree) to wine-git-commit.
#   Reset the Wine Staging Git tree (wine-git-tree) to wine-wine_staging_git_commit.
#   Apply the Wine Staging patchset (using 'git am' backend).
#   Clean up any uncommited changes, in the Wine Git tree (wine-git-tree), post-patching.
#
git_am_wine_staging_patchset()
{
	(($# == 4)) || die "invalid parameter count: ${#} (4)"
	
	local 	__wine_git_tree="${1}" \
			__wine_staging_git_tree="${2}" \
			__wine_git_commit="${3}" \
			__wine_staging_git_commit="${4}"
	local 	patch_install_script="${__wine_staging_git_tree}/patches/patchinstall.sh" \
			tmp_file

	reset_git_tree "${__wine_staging_git_tree}" "${__wine_staging_git_commit}"
	pushd "${__wine_git_tree}" >/dev/null || die "pushd failed"
	git am --abort &>/dev/null
	git clean -fd || die "git clean failed"
	git reset --hard "${__wine_git_commit}" || die "git reset failed"
	tmp_file="$(mktemp)"
	printf "\\nApplying Wine Staging patchset ...\\n"
	if ! "${patch_install_script}" --backend=git-am --all 2>"${tmp_file}"; then
		cat "${tmp_file}"
		[[ -f "${tmp_file}" ]] && rm -f "${tmp_file}" 2>/dev/null
		die "'${patch_install_script}' failed"
	fi
	[[ -f "${tmp_file}" ]] && rm -f "${tmp_file}" 2>/dev/null
	git clean -fd || die "git clean failed"
	git reset --hard HEAD || die "git reset failed"
	popd >/dev/null || die "popd failed"
}

# git_am_esync_patchset()
#
# Parameters:
#   1>   wine-git-tree    :  Wine Git tree root directory              (string)
#   2>   source-directory :  Pre-rebased wine-esync patchset directory (string)
#
# Description:
#   Apply esync patches in numerical sequence to the Wine source, in the Wine Git tree 
#   directory (wine-git-tree). Use 'git am' to apply these patches. Clean up the Wine
#   Git tree, if any patch fails to apply.
#
git_am_esync_patchset()
{
	(($# == 2)) || die "invalid parameter count: ${#} (2)"

	local 	__wine_git_tree="${1}" \
			__source_directory="${2}"
	local 	__git_error __i_patch __esync_patch __patch_error

	pushd "${__wine_git_tree}" >/dev/null || die "pushd failed"
	printf "\\nApplying (using git am) esync patchset from directory: '%s' ...\\n" "${__source_directory}"
	for __i_patch in $(seq -w "${PATCHSET_START}" "${PATCHSET_END}"); do
		__esync_patch="$(find "${__source_directory}" -name "${__i_patch}*.patch" -printf '%f' 2>/dev/null)"
		[[ -f "${__source_directory}/${__esync_patch}" ]] || die "patch: '${__esync_patch}' ; invalid"
		printf "Applying esync patch: '%s' ...\\n" "${__esync_patch}"
		if __patch_error="$( patch -F1 -p1 --verbose --dry-run < "${__source_directory}/${__esync_patch}" )" \
		&& __git_error="$( git am --ignore-whitespace "${__source_directory}/${__esync_patch}" )"; then
			continue
		fi

		printf "%s\\n%s\\n" "${__patch_error}" "${__git_error}" >&2
		git am --abort &>/dev/null
		git clean -fxd &>/dev/null
		# shellcheck disable=SC2164
		popd &>/dev/null
		die "git am failed"
	done
	popd >/dev/null || die "popd failed"
}

# squash_esync_patchset()
#
# Parameters:
#   1>   wine-git-tree                    :  Wine Git tree root directory                                        (string)
#   2>   wine-staging-git-tree            :  Wine Staging Git tree root directory                                (string)
#   3>   esync-sources-directory          :  Root directory containing all (required) esync sources              (string)
#   4>   esync-rebasing-patches-directory :  Specific rebasing patches to use with the current esync version     (string)
#   5>   destination-directory            :  Target directory in which to store squashed, rebased esync patchset (string)
#
# Description:
#   Ensure the destination-directory exists. Then reset the Wine Git tree (wine-git-tree)
#   to the commit, embedded in the esync-rebasing-patches-directory path. If rebasing against Wine Staging
#   then convert this commit to a valid Wine Staging Git commit and apply the Wine Staging patchset.
#   Then apply the rebased esync patchset from a subdirectory of the: esync-sources-directory ;
#   based on the esync version embedded in the esync-rebasing-patches-directory path.
#   Finally regenerate a reduced, rebased esync patchset, from the Wine Git tree. Each
#   esync patch corresponds to the diff for a single Wine Source file at this point.
#   This enables the esync patchset to applied out-of-order and, in addition, reduces the size of the
#   resulting patchset.
#
squash_esync_patchset()
{
	(($# == 5)) || die "invalid parameter count: ${#} (5)"

	local 	__wine_git_tree="${1}" \
			__wine_staging_git_tree="${2}" \
			__esync_sources_directory="${3}" \
			__esync_rebasing_patches_directory="${4}" \
			__destination_directory="${5}"

	local __base_wine_git_commit __esync_source_directory \
		__patch_file __patch_file_mangled \
		__target_patch_file __target_patch_path \
		__wine_git_commit __wine_staging_git_commit

	mkdir -p "${__destination_directory}" || die "mkdir -p failed"
	__wine_git_commit="$(basename "${__esync_rebasing_patches_directory}")"
	__esync_version="$(basename "$(dirname "$(dirname "${__esync_rebasing_patches_directory}")")")"
	__esync_source_directory="${__esync_sources_directory}/${__esync_version}/esync"
	printf "\\nApplying esync rebasing patches from: '%s'\\n" "${__esync_rebasing_patches_directory}"
	printf "Applying esync rebasing patches to esync source directory: '%s'\\n" "${__esync_source_directory}"
	apply_esync_rebasing_patchset "${__esync_source_directory}" "${__esync_rebasing_patches_directory}"
	__base_wine_git_commit="${__wine_git_commit}"
	reset_git_tree "${__wine_git_tree}" "${__wine_git_commit}"	
	if [[ "${__wine_staging_git_tree}" != "." ]]; then
		convert_wine_to_wine_staging_commit "${__wine_git_tree}" "${__wine_staging_git_tree}" \
											"__wine_git_commit" "__wine_staging_git_commit"
		printf "Wine git commit: %s\\n" "${__wine_git_commit}"
		printf "Wine Staging git commit: %s\\n\\n" "${__wine_staging_git_commit}"
		git_am_wine_staging_patchset "${__wine_git_tree}" "${__wine_staging_git_tree}" \
									"${__wine_git_commit}" "${__wine_staging_git_commit}"
	fi

	if [[ "${__base_wine_git_commit}" == "${__wine_git_commit}" ]]; then
		printf "\\nBase Wine commit: %s\\n" "${__base_wine_git_commit}"
	else
		printf "\\nBase Wine commit: %s ( Working with Wine git commit: %s )\\n" "${__base_wine_git_commit}" "${__wine_git_commit}"
	fi

	git_am_esync_patchset "${__wine_git_tree}" "${__esync_source_directory}"

	pushd "${__wine_git_tree}" >/dev/null || die "pushd failed"
	printf "\\nSquashing esync patchset, in directory: '%s'\\n" "${__esync_source_directory}"
	printf "Squashing esync patchset, targetting directory: '%s'\\n" "${__destination_directory}"
	awk '{ if (($1=="diff") && ($NF !~ "^[[:blank:]]*$")) { sub("^[[:alpha:]]*/","/",$NF); printf("%s\n",$NF) } }' "${__esync_source_directory}"/{0001..0083}*.patch \
	| sort -V | uniq | while read -r __patch_file; do
		mangle_path "${__patch_file}" __patch_file_mangled
		__target_patch_file="${PATCHFILE_PREFIX}${__patch_file_mangled}.patch"
		__target_patch_path="${__destination_directory}/${__target_patch_file}"
		git diff HEAD~$((PATCHSET_TOTAL)) HEAD "${__patch_file#/}" >"${__target_patch_path}" || die "git diff failed"
		if [[ ! -f "${__target_patch_path}" ]]; then
			die "git diff HEAD~$((PATCHSET_TOTAL)) HEAD '${__patch_file}' failed"
		elif [[ ! -s "${__target_patch_path}" ]]; then
			rm -f "${__target_patch_path}" || die "rm failed"
			continue
		fi

		printf "Generating new patch file: '%s'\\n" "${__target_patch_file}"
	done
	popd >/dev/null || die "popd failed"
}

main()
{
	(($# == 5)) || die "invalid parameter count: ${#} (5)" 1

	local 	__wine_git_tree __wine_staging_git_tree \
			__esync_sources_root __destination_root __i=0 \
			__staging_directory \
			__patchset_subdirectory __patchset_total __target_patchset_subdirectory

	__wine_git_tree="$(readlink -f "${1}" 2>/dev/null)"
	__wine_staging_git_tree="$(readlink -f "${2}" 2>/dev/null)"
	__esync_sources_root="$(readlink -f "${3}" 2>/dev/null)"
	__esync_rebase_patches_root="$(readlink -f "${4}" 2>/dev/null)"
	__destination_root="$(readlink -f "${5}" 2>/dev/null)"

	if [[ -z "${__wine_git_tree}" || ! -d "${__wine_git_tree}" ]]; then
		die "Wine git tree path: '${__wine_git_tree}' ; is not a valid directory"
	elif [[ ! -d "${__wine_git_tree}/.git" ]]; then
		die "Wine git tree path: '${__wine_git_tree}' ; is not a valid git clone directory"
	fi
	if [[ -z "${__wine_staging_git_tree}" || ! -d "${__wine_staging_git_tree}" ]]; then
		die "Wine Staging git tree path: '${__wine_staging_git_tree}' ; is not a valid directory"
	elif [[ ! -d "${__wine_staging_git_tree}/.git" ]]; then
		die "Wine Staging git tree path: '${__wine_staging_git_tree}' ; is not a valid git clone directory"
	fi
	if [[ -z "${__esync_sources_root}" || ! -d "${__esync_sources_root}" ]]; then
		die "Source root path: '${__esync_sources_root}' ; is not a valid directory"
	fi
	if [[ -z "${__esync_rebase_patches_root}" || ! -d "${__esync_rebase_patches_root}" ]]; then
		die "Source root path: '${__esync_rebase_patches_root}' ; is not a valid directory"
	fi
	if [[ -z "${__destination_root}" ]]; then
		die "Destination root path: '${__destination_root}' ; is not a valid directory"
	elif [[ ! -d "${__destination_root}" ]]; then
		mkdir -p "${__destination_root}" || die "mkdir failed"
	fi
	git_garbage_collect "${__wine_git_tree}"
	git_garbage_collect "${__wine_staging_git_tree}"
	git_create_branch "${__wine_git_tree}" "wine-esync"
	git_create_branch "${__wine_staging_git_tree}" "wine-staging-esync"
	printf "__esync_rebase_patches_root=%s\\n" "${__esync_rebase_patches_root}"
	__patchset_total="$(find "${__esync_rebase_patches_root}" -mindepth 3 -type d -regextype posix-awk -regex ".*/${SHA1_REGEXP}" | wc  -l)"
	find "${__esync_rebase_patches_root}" -mindepth 3 -type d -regextype posix-awk -regex ".*/${SHA1_REGEXP}" -print0 | \
	while IFS= read -r -d '' __patchset_subdirectory; do
		__patchset_subdirectory="${__patchset_subdirectory#${__esync_rebase_patches_root}}"
		__patchset_subdirectory="${__patchset_subdirectory#/}"
		__patchset_subdirectory="${__patchset_subdirectory%/}"
		__target_patchset_subdirectory="${__patchset_subdirectory#*/}"
		printf "\\n\\nProcessing directory %02d / %02d : '%s' ...\\n\\n" \
				"$((++__i))" "$((__patchset_total))" "${__patchset_subdirectory}"
		download_unpack_esync_patchsets "${__esync_sources_root}"
		if [[ "${__target_patchset_subdirectory}" =~ ^wine[-]staging ]]; then
			__staging_directory="${__wine_staging_git_tree}"
		elif [[ "${__target_patchset_subdirectory}" =~ ^wine[-]vanilla ]]; then
			__staging_directory="."
		else
			die "unknown Wine package base: ${__patchset_subdirectory}"
		fi
		squash_esync_patchset "${__wine_git_tree}" "${__staging_directory}" \
						"${__esync_sources_root}" \
						"${__esync_rebase_patches_root}/${__patchset_subdirectory}" \
						"${__destination_root}/${__target_patchset_subdirectory}"
	done
}

main "${@}"
