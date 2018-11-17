#!/usr/bin/env bash


declare -a ARRAY_ESYNC_PATCH_COMMITS=(
		"f8e0bd1b0d189d5950dc39082f439cd1fc9569d5" "12276796c95007fc12eb38a41ca25b4daee7e1b3"
		"a7aa192a78d02d28f2bbae919a3f5c726e4e9e60" "c61c33ee66ea0e97450ac793ebc4ac41a1ccc793"
		"57212f64f8e4fef0c63c633940e13d407c0f2069" "24f47812165a5dcb2b22825e47ccccbbd7437b8b"
		"2f17e0112dc0af3f0b246cf377e2cb8fd7a6cf58" "2600ecd4edfdb71097105c74312f83845305a4f2"
)
declare ESYNC_STAGING_SUPPORT_INDEX=1
declare ESYNC_VANILLA_SUPPORT_INDEX=0
declare ESYNC_BASE_URL="https://github.com/zfigura/wine/releases/download"
declare ESYNC_VERSION="${ESYNC_VERSION:-esyncb4478b7}"
declare ESYNC_SHA256="2cacc317e07531987c41c5aceb41862b06d4717840916dfc01c11513b359a962"
declare ESYNC_TARBALL="esync.tgz"
declare SCRIPT_NAME

SCRIPT_NAME="$( basename "${0}" )"


# die()
#
# Parameters:
#   1>   message       :  error message to display        (string)
#  [2>]  usage=0       :        display usage message (1) (boolean)
#                      :  don't display usage message (0)
#
# Description:
#   Simple function to exit the script, on an error.
#   Displays a usage message, when invalid command line parameters
#   are specified.
#
function die()
{
	local usage="${2:-0}"

	if ((usage)); then
		printf "Usage:\\n%s: SOURCE-DIRECTORY TARGET-DIRECTORY [AWK-SCRIPT-DIRECTORY]\\n\\n" "${SCRIPT_NAME}" >&2
	fi
	printf "%s: %s: %s\\n" "${SCRIPT_NAME}" "${FUNCNAME[1]}()" "${1}" >&2
	exit 1
}

# download_esync_patchset()
#
# Parameters:
#   1>   source_directory       :  directory, to store esync tarball (string)
#
# Description:
#   Downloads a esync release tarball - if one is not present in the source
#   directory already (with a valid checksum). sha256sum is used to check
#   if the downloaded esync release tarball is valid.
#
function download_esync_patchset()
{
	(($# == 1)) || die "invalid number of arguments: $# (1)"

	local __source_directory="${1%/}"

	pushd "${__source_directory}" || die "pushd failed"
	if [[ -f "${__source_directory}/${ESYNC_TARBALL}" ]] \
		&& sha256sum -c --quiet <<< "${ESYNC_SHA256} ${ESYNC_TARBALL}"
	then
		popd || die "popd failed"
		return 0
	fi

	wget "${ESYNC_BASE_URL}/${ESYNC_VERSION}/${ESYNC_TARBALL}" || die "wget failed"
	if ! sha256sum -c --quiet <<< "${ESYNC_SHA256} ${ESYNC_TARBALL}"; then
		die "sha256sum failed on esync tarball: '${ESYNC_BASE_URL}/${ESYNC_VERSION}/${ESYNC_TARBALL}'"
	fi
	popd || die "popd failed"
}

# unpack_esync_patchset()
#
# Parameters:
#   1>   source_directory       :  root directory, in which to unpack esync tarball (string)
#
# Description:
#   Unpack a (previously) download esync tarball and checks the sha256sum is valid.
#
function unpack_esync_patchset()
{
	(($# == 1)) || die "invalid number of arguments: $# (1)"

	local __source_directory="${1%/}"

	pushd "${__source_directory}" || die "pushd failed"
	if ! sha256sum -c --quiet <<< "${ESYNC_SHA256} ${ESYNC_TARBALL}"; then
		die "sha256sum failed on esync tarball: '${ESYNC_BASE_URL}/${ESYNC_VERSION}/${ESYNC_TARBALL}'"
	fi
	rm -rf "${__source_directory:?}/${ESYNC_TARBALL%%.*}" || die "rm -rf failed"
	tar xvfa "${__source_directory}/${ESYNC_TARBALL}" || die "tar xvfa failed"
	popd || die "popd failed"
}

# generate_rebased_esync_patchset()
#
# Parameters:
#   1>   source_directory       :  root directory, to store/unpack esync tarball               (string)
#   2>   target_directory       :  root directory, in which to store rebased esync patch diffs (string)
#   3>   awk_scripts_directory  :  directory where awk processing scripts are stored           (string)
#   4>   esync_rebase_index     :  index into an array of Wine Git commit rebase points        (integer)
#   5>   staging                :  wine-vanilla (0) / wine-staging (1) package                 (boolean)
#
# Description:
#   Generate a directory of esync patch diffs, for a specified Wine Git commit
#   and wine-staging / wine-vanilla package.
#
function generate_rebased_esync_patchset()
{
	(($# == 5)) || die "invalid number of arguments: $# (5)"

	local  __source_directory="${1%/}" __target_directory="${2%/}" \
			__awk_scripts_directory="${3%/}" __esync_rebase_index="${4}" \
			__staging="${5}" __array_size="${#ARRAY_ESYNC_PATCH_COMMITS[@]}" \
			__patch_file __patch_file_path __source_esync_directory \
			__target_esync_directory __target_esync_patch_file __target_patch

	if (( __staging)); then
		((__esync_rebase_index < ESYNC_STAGING_SUPPORT_INDEX)) && return 0
		__target_esync_directory="wine-staging"
	else
		((__esync_rebase_index < ESYNC_VANILLA_SUPPORT_INDEX)) && return 0
		__target_esync_directory="wine-vanilla"
	fi

	__source_esync_directory="${__source_directory}/${ESYNC_TARBALL%%.*}"
	__target_esync_directory="${__target_directory}/${ESYNC_VERSION}/${__target_esync_directory}/${ARRAY_ESYNC_PATCH_COMMITS[__esync_rebase_index]}"
	mkdir -p "${__target_esync_directory}" || die "mkdir -p failed"

	printf "\\nRebasing esync patchset against Wine Git commit: %s\\n" "${ARRAY_ESYNC_PATCH_COMMITS[__esync_rebase_index]}"
	for __patch_file_path in "${__source_esync_directory}/"{0001..0083}*.patch; do
		if awk -v__staging="${__staging}" \
			-vesync_patchset_commits="${ARRAY_ESYNC_PATCH_COMMITS[*]}" \
			-vesync_rebase_patchset="${ARRAY_ESYNC_PATCH_COMMITS[__esync_rebase_index]}" \
			-vtarget_esync_directory="${__target_esync_directory}" \
			-f "${__awk_scripts_directory}/wine-esync-common.awk" \
			-f "${__awk_scripts_directory}/wine-esync-preprocess.awk" \
			"${__patch_file_path}"
		then
			:
		elif (($?==255)); then
			continue
		else
			die "preprocessing patch failed: '${__patch_file_path}'"
		fi

		__patch_file="$(basename "${__patch_file_path}")"
		__target_esync_patch_file="${__target_esync_directory}/${__patch_file}"
		if [[ ! -f "${__target_esync_patch_file}" ]]; then
			die "patch file path invalid: '${__target_esync_patch_file}'"
		fi
		__target_patch="${__patch_file:0:4}.patch"
		diff -Nau "${__patch_file_path}" "${__target_esync_patch_file}" > "${__target_esync_directory}/${__target_patch}"
		[[ -f "${__target_esync_directory}/${__target_patch}" ]] || die "diff failed"
		rm -f "${__target_esync_patch_file}" || die "rm failed"
		if [[ ! -s "${__target_esync_directory}/${__target_patch}" ]]; then
			rm -f "${__target_esync_directory}/${__target_patch}" || die "rm failed"
		else
			sed -i -e "s|${__source_esync_directory}|a|g" -e "s|${__target_esync_directory}|b|g" \
				"${__target_esync_directory}/${__target_patch}" || die "sed failed"
		fi
	done
}

# generate_all_rebased_esync_patchsets()
#
# Parameters:
#   1>   source_directory       :  root directory, to store/unpack esync tarball               (string)
#   2>   target_directory       :  root directory, in which to store rebased esync patch diffs (string)
#   3>   awk_scripts_directory  :  directory where awk processing scripts are stored           (string)
#
# Description:
#   Generate directories of esync patch diffs (for each Wine Git commit,
#   where the wine-esync patchset needs rebasing) for the packages wine-vanilla (Wine)
#   and wine-staging (Wine Staging).
#
function generate_all_rebased_esync_patchsets()
{
	(($# == 3)) || die "invalid number of arguments: $# (3)"

	local  __source_directory="${1%/}" __target_directory="${2%/}" \
			__awk_scripts_directory="${3%/}" \
			__array_size="${#ARRAY_ESYNC_PATCH_COMMITS[@]}" __esync_rebase_index __staging

	for __staging in {0..1}; do
		# shellcheck disable=SC2051
		for ((__esync_rebase_index=0 ; __esync_rebase_index < __array_size ; ++__esync_rebase_index)); do
			generate_rebased_esync_patchset  "${__source_directory}" "${__target_directory}" \
									"${__awk_scripts_directory}" "${__esync_rebase_index}" "${__staging}"
		done
	done
}

# main()
#
# Parameters:
#   1>   source_directory       :  root directory to store/unpack esync tarball               (string)
#   2>   target_directory       :  root directory in which to store rebased esync patch diffs (string)
#  [3>]  awk_scripts_directory  :  directory where awk processing scripts are stored          (optional, string)
#
# Description:
#   Takes command line parameters and processes these steps:
#    1) download the specified esync release tarball
#    2) unpack the esync tarball
#    3) generate directories of esync patch diffs (for each Wine Git commit,
#       where the wine-esync patchset needs rebasing) for the packages wine-vanilla (Wine)
#       and wine-staging (Wine Staging)
#
#    NB: if the awk_scripts_directory argument is not supplied, it is assumed to be the same as the
#        directory this script is stored in.
function main()
{
	(((2 <= $#) && ($# <= 3))) || die "invalid number of arguments: $# (2-3)" 1

	local  __source_directory="${1%/}" __target_directory="${2%/}" __awk_scripts_directory="${3%/}"

	[[ -d "${__source_directory}" ]] 	|| die "argument 1: not a valid directory: '${__source_directory}'" 1
	[[ -d "${__target_directory}" ]] 	|| die "argument 2: not a valid directory: '${__target_directory}'" 1
	[[ -z "${__awk_scripts_directory}" ]] && __awk_scripts_directory="$(dirname "${0}")"
	if [[ ! -d "${__awk_scripts_directory}" ]]; then
		die "argument 3: not a valid directory: '${__awk_scripts_directory}'" 1
	elif [[ ! -f "${__awk_scripts_directory}/wine-esync-common.awk" ]]; then
		die "argument 3: awk script: 'wine-esync-common.awk' missing from directory: '${__awk_scripts_directory}'" 1
	elif [[ ! -f "${__awk_scripts_directory}/wine-esync-preprocess.awk" ]]; then
		die "argument 3: awk script: 'wine-esync-preprocess.awk' missing from directory: '${__awk_scripts_directory}'" 1
	fi

	download_esync_patchset "${__source_directory}"
	unpack_esync_patchset "${__source_directory}"
	generate_all_rebased_esync_patchsets "${__source_directory}" "${__target_directory}" "${__awk_scripts_directory}"
}

main "${@}"
