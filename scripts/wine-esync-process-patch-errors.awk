#!/usr/bin/env awk

# wine-esync-process-patch-errors.awk
#
# Parameters:
#   >   patch_error  :  patch error message  (string)
#   >   [awk file]   :  patch with error     (file)
#
# Description
#   Parse the supplied patch error string (patch_error) and dump all failing
#   hunks from the supplied patch file (using an inverted terminal mode,
#   with prefixed line numbering)
BEGIN{
	initialise_tty_mode_codes(tty_mode_codes_array)

	# declare regular expressions
	leading_directory_regex="^[^\/]*\/"
	diff_hunk_regex="^[@][@] [-][[:digit:]]*,[[:digit:]]* [+][[:digit:]]*,[[:digit:]]* [@][@]"
	patch_hunk_error_regex="^Hunk [#][[:digit:]]* FAILED"
	hunk_line_regex="^[ +-@]"

	# generate an 80 coloumn separator string
	separator="____________________"
	separator=(separator separator separator separator)

	error_line_count=split(patch_error, error_line_array, "\n")
}
{
	if ($0 == "-- ") {
		diff_hunk_open=0
	}
	else if (($1 == "diff") && ($2 == "--git")) {
		diff_file=$NF
		diff_hunk=0
		diff_hunk_open=0
		sub(leading_directory_regex, "", diff_file)
	}
	else if ($0 ~ diff_hunk_regex) {
		++diff_hunk
		diff_hunk_open=1
	}

	if (diff_hunk_open && ($0 ~ hunk_line_regex)) {
		diff_line=++array_diff_hunks[diff_file,diff_hunk,0]
		array_diff_hunks[diff_file,diff_hunk,diff_line]=sprintf("%04d: %s%s%s",
																FNR, tty_mode_codes_array["reverse"],
																$0, tty_mode_codes_array["reset"])
	}
}
END{
	for (line=1 ; line<=error_line_count ; ++line) {
		if (error_line_array[line] ~ "^[|]diff") {
			element_count=split(error_line_array[line], array_elements)
			diff_file=array_elements[element_count]
			sub("^[^\/]*\/", "", diff_file)
			++diff_file_count
		}
		else if (error_line_array[line] ~ patch_hunk_error_regex) {
			diff_hunk=error_line_array[line]
			gsub("^Hunk [#]| FAILED.*$", "", diff_hunk)

			printf("(%02d) file: %s%s%s ... %s\n",
				   diff_file_count, tty_mode_codes_array["reverse"],
				   diff_file, tty_mode_codes_array["reset"],
				   error_line_array[line])
			printf("%s\n\n", separator)
			diff_hunk_size=array_diff_hunks[diff_file,diff_hunk,0]
			for (idiff_line=1 ; idiff_line<=diff_hunk_size ; ++idiff_line) {
				printf("%s\n", array_diff_hunks[diff_file,diff_hunk,idiff_line])
			}
			printf("%s\n\n", separator)
		}
	}
}