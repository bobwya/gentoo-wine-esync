#!/usr/bin/env bash


declare -a ARRAY_ESYNC_PATCH_COMMITS=(
		"f8e0bd1b0d189d5950dc39082f439cd1fc9569d5" "12276796c95007fc12eb38a41ca25b4daee7e1b3"
		"a7aa192a78d02d28f2bbae919a3f5c726e4e9e60" "c61c33ee66ea0e97450ac793ebc4ac41a1ccc793"
		"57212f64f8e4fef0c63c633940e13d407c0f2069" "24f47812165a5dcb2b22825e47ccccbbd7437b8b"
		"2f17e0112dc0af3f0b246cf377e2cb8fd7a6cf58" "2600ecd4edfdb71097105c74312f83845305a4f2"
)
declare ESYNC_STAGING_SUPPORT_INDEX=2
declare ESYNC_VANILLA_SUPPORT_INDEX=0
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
declare SCRIPT_DIRECTORY SCRIPT_NAME
SCRIPT_NAME="$(readlink -f "${0}")"
SCRIPT_DIRECTORY="$(dirname "${SCRIPT_NAME}")"
SCRIPT_NAME="$(basename "${SCRIPT_NAME}")"

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

	local _source_directory="${1%/}" _esync_tarball _i

	pushd "${_source_directory}" >/dev/null || die "pushd failed"
	for _i in "${!ESYNC_VERSION_ARRAY[@]}"; do
        _esync_tarball="${ESYNC_VERSION_ARRAY[_i]}.${TARBALL_EXT}"
        if [[ -f "${_source_directory}/${_esync_tarball}" ]] \
            && sha256sum -c --quiet <<< "${ESYNC_SHA256_ARRAY[_i]} ${_esync_tarball}"
        then
            continue
        fi

        wget "${ESYNC_BASE_URL}/${ESYNC_VERSION_ARRAY[_i]}/esync.${TARBALL_EXT}" -O "${_esync_tarball}" || die "wget failed"

        if ! sha256sum -c --quiet <<< "${ESYNC_SHA256_ARRAY[_i]} ${_esync_tarball}"; then
            die "sha256sum failed on esync tarball: '${_esync_tarball}'"
        fi
    done
	popd >/dev/null || die "popd failed"
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

	local _source_directory="${1%/}" _esync_directory _esync_tarball _i

	pushd "${_source_directory}" >/dev/null || die "pushd failed"
	for _i in "${!ESYNC_VERSION_ARRAY[@]}"; do
        _esync_directory="${ESYNC_VERSION_ARRAY[_i]}"
        _esync_tarball="${_esync_directory}.${TARBALL_EXT}"
        if ! sha256sum -c --quiet <<< "${ESYNC_SHA256_ARRAY[_i]} ${_esync_tarball}"; then
            die "sha256sum failed on esync tarball: '${_esync_tarball}'"
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

	local  _source_directory="${1%/}" _target_directory="${2%/}" \
			_awk_scripts_directory="${3%/}" _esync_rebase_index="${4}" \
			_staging="${5}" _array_size="${#ARRAY_ESYNC_PATCH_COMMITS[@]}" \
			_esync_tarball _esync_version _i \
			_patch_file _patch_file_path _source_esync_directory _target_esync_directory \
			_target_esync_version _target_esync_patch_file _target_patch

	if ((_staging)); then
		((_esync_rebase_index < ESYNC_STAGING_SUPPORT_INDEX)) && return 0
		_target_esync_version="wine-staging"
	else
		((_esync_rebase_index < ESYNC_VANILLA_SUPPORT_INDEX)) && return 0
		_target_esync_version="wine-vanilla"
	fi

	case "${_esync_rebase_index}" in
        [0-5])
            _i=0;;
        [6-7])
            _i=1;;
	esac

    _esync_version="${ESYNC_VERSION_ARRAY[_i]}"
    _esync_tarball="${_esync_version}.${TARBALL_EXT}"
	_source_esync_directory="${_source_directory}/${_esync_version}/esync"
	_target_esync_directory="${_target_directory}/${_esync_version}/${_target_esync_version}/${ARRAY_ESYNC_PATCH_COMMITS[_esync_rebase_index]}"
	mkdir -p "${_target_esync_directory}" || die "mkdir -p failed"

	printf "\\nRebasing esync patchset, for app-emulation/${_target_esync_version}, against Wine Git commit: %s\\n" "${ARRAY_ESYNC_PATCH_COMMITS[_esync_rebase_index]}"
	for _patch_file_path in "${_source_esync_directory}/"{0001..0083}*.patch; do
		if awk -vstaging="${_staging}" \
			-vesync_rebase_index="${_esync_rebase_index}" \
			-vtarget_esync_directory="${_target_esync_directory}" \
			-f "${_awk_scripts_directory}/wine-esync-common.awk" \
			-f "${_awk_scripts_directory}/wine-esync-preprocess.awk" \
			"${_patch_file_path}"
		then
			:
		elif (($?==255)); then
			continue
		else
			die "preprocessing patch failed: '${_patch_file_path}'"
		fi

		_patch_file="$(basename "${_patch_file_path}")"
		_target_esync_patch_file="${_target_esync_directory}/${_patch_file}"
		if [[ ! -f "${_target_esync_patch_file}" ]]; then
			die "patch file path invalid: '${_target_esync_patch_file}'"
		fi
		_target_patch="${_patch_file:0:4}.patch"
		diff -Nau "${_patch_file_path}" "${_target_esync_patch_file}" > "${_target_esync_directory}/${_target_patch}"
		[[ -f "${_target_esync_directory}/${_target_patch}" ]] || die "diff failed"
		rm -f "${_target_esync_patch_file}" || die "rm failed"
		if [[ ! -s "${_target_esync_directory}/${_target_patch}" ]]; then
			rm -f "${_target_esync_directory}/${_target_patch}" || die "rm failed"
		else
			sed -i -e "s|${_source_esync_directory}|a|g" -e "s|${_target_esync_directory}|b|g" \
				"${_target_esync_directory}/${_target_patch}" || die "sed failed"
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

	local  _source_directory="${1%/}" _target_directory="${2%/}" \
			_awk_scripts_directory="${3%/}" \
			_array_size="${#ARRAY_ESYNC_PATCH_COMMITS[@]}" _esync_rebase_index _staging

	for _staging in {0..1}; do
		# shellcheck disable=SC2051
		for ((_esync_rebase_index=0 ; _esync_rebase_index < _array_size ; ++_esync_rebase_index)); do
			generate_rebased_esync_patchset  "${_source_directory}" "${_target_directory}" \
									"${_awk_scripts_directory}" "${_esync_rebase_index}" "${_staging}"
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

	local  _source_directory="${1%/}" _target_directory="${2%/}" _awk_scripts_directory="${3%/}"

	if [[ ! -d "${_source_directory}" ]]; then
        die "argument 1: not a valid directory: '${_source_directory}'" 1
    else
        _source_directory="$( readlink -f "${_source_directory}" )"
    fi
	if [[ ! -d "${_target_directory}" ]]; then
        die "argument 2: not a valid directory: '${_target_directory}'" 1
    else
        _target_directory="$( readlink -f "${_target_directory}" )"
    fi
	[[ -z "${_awk_scripts_directory}" ]] && _awk_scripts_directory="${SCRIPT_DIRECTORY}"
	if [[ ! -d "${_awk_scripts_directory}" ]]; then
		die "argument 3: not a valid directory: '${_awk_scripts_directory}'" 1
	elif [[ ! -f "${_awk_scripts_directory}/wine-esync-common.awk" ]]; then
		die "argument 3: awk script: 'wine-esync-common.awk' missing from directory: '${_awk_scripts_directory}'" 1
	elif [[ ! -f "${_awk_scripts_directory}/wine-esync-preprocess.awk" ]]; then
        die "argument 3: awk script: 'wine-esync-preprocess.awk' missing from directory: '${_awk_scripts_directory}'" 1
	fi

	download_esync_patchset "${_source_directory}"
	unpack_esync_patchset "${_source_directory}"
	generate_all_rebased_esync_patchsets "${_source_directory}" "${_target_directory}" "${_awk_scripts_directory}"
}

main "${@}"
