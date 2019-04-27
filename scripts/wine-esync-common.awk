#!/usr/bin/env awk

# initialise_tty_mode_codes(tty_mode_codes_array)
#
# Parameters:
#   1<  tty_mode_codes_array  :  array of common terminal code sequences    (string array)
#
# Description
#   Returns an array containing the (generated) shell code sequences for various terminal
#   modesetting operations (colour change, reverse mode, reseting). These array entries
#   can be passed directly to print/printf to change the terminal mode for terminal output.
function initialise_tty_mode_codes(tty_mode_codes_array,
		command_tty)
{
	command_tty="tput rev"
	command_tty | getline tty_mode_codes_array["reverse"]
	close(command_tty)
	command_tty="tput setaf 1"
	command_tty | getline tty_mode_codes_array["red"]
	close(command_tty)
	command_tty="tput setaf 2"
	command_tty | getline tty_mode_codes_array["green"]
	close(command_tty)
	command_tty="tput setaf 3"
	command_tty | getline tty_mode_codes_array["yellow"]
	close(command_tty)
	command_tty="tput setaf 4"
	command_tty | getline tty_mode_codes_array["blue"]
	close(command_tty)
	command_tty="tput setaf 5"
	command_tty | getline tty_mode_codes_array["magenta"]
	close(command_tty)
	command_tty="tput setaf 6"
	command_tty | getline tty_mode_codes_array["cyan"]
	close(command_tty)
	command_tty="tput setaf 7"
	command_tty | getline tty_mode_codes_array["white"]
	close(command_tty)
	command_tty="tput sgr0"
	command_tty | getline tty_mode_codes_array["reset"]
	close(command_tty)
}

# dump_error(text)
#
# Parameters:
#   >  file_name       :  patch file being processed by awk    (string,  global)
#   >  diff_array      :  array of (patch file) diff data      (string/integer array)
#
# Description
#   Dumps a fixed format error message to stderr. An error will occur:
#   * when the script is unable to match a search line, in the current diff hunk
#   * when a diff file is not found
#   in the current patch file.
function dump_error()
{
	if (diff_array["exit code"] == 255)
		return

	printf("%s: file: '%s' hunk: %d [%d] (lines: %04d-%04d) failed\n",
			file_name,
			diff_array["exit file"], diff_array["exit ihunk"], diff_array["exit code"],
			diff_array["exit start line"], diff_array["exit end line"]) >"/dev/stderr"
}

# squash_array(text)
#
# Parameters:
#   1>  sparse_array          :  array of (numerical indicies)         (array)
#
# Description
#   Compact a sparse array (with holes). Entry [0] should contain the total entries.
#   This total is updated, posted the compaction process.
function squash_array(sparse_array,
		count, i, total)
{
	total = sparse_array[0]
	for (i = 1 ; i <= total ; ++i) {
		if (sparse_array[i])
			sparse_array[++count] = sparse_array[i]
	}
	for (i = count+1 ; i <= total ; ++i) {
		if (sparse_array[i])
			delete sparse_array[i]
	}
	sparse_array[0] = count
}

# text2regexp(text)
#
# Parameters:
#   1>  file_path  :  text               (string)
#   returns        :  regular expression (string)
#
# Description
#   Sanitises the specified text, turning it into
#   a string that can be used as a regular expression.
#   Special characters, for regular expressions, are escaped.
#   Start line '^' and end line '$' specifiers are retained (if at the
#   start and end of the line respectively).
#   Spaces ' ' are replaced with a variable width blank match.
#   An asterisk '*' character will match a variable width block.
function text2regexp(text,
		endmarker,regexp,startmarker)
{
		regexp=text
		startmarker=sub("^\\^", "", regexp)
		endmarker=sub("\\$$", "", regexp)
		# Escape all control regex characters
		gsub("\\\\", "[&]", regexp)
		gsub("\\!|\\\"|\\#|\\$|\\%|\\&|\x27|\\(|\\)|\\+|\\,|\\-|\\.|\\/|\\:|\\;|\x3c|\\=|\x3e|\\?|\\@|\\[|\\]|\\{|\\|\\}|\\~", "[&]", regexp)
		gsub("\\*", ".*", regexp)
		gsub("\x20", "[[:blank:]][[:blank:]]*", regexp)
		regexp=((startmarker ? "^" : "") regexp (endmarker ? "$" : ""))
		gsub("\\|", "[&]", regexp)

		return regexp
}

# get_file_name(file_path)
#
# Parameters:
#   1>  file_path  :  file path      (string)
#   returns        :  file path base (string)
#
# Description
#   Returns the basename (final file or directory
#   name), from the specified file path.
function get_file_name(file_path,
		command_basename, file_name)
{
	command_basename=("basename \"" file_path "\"")
	command_basename | getline file_name
	close(command_basename)

	return file_name
}

# get_indent(line_text)
#
# Parameters:
#   1>  line_text  :  line text   (string)
#   returns        :  line indent (string)
#
# Description
#   If the current line starts with a blank, '+' or
#   a '-', then return a string with the prefix
#   blank portion of the line. The returned indent
#   string is all blank; a leading '+' / '-' (if
#   present) will be replaced with a space.
function get_indent(line_text,
		indent)
{
	match(line_text, "^[-+[:blank:]][[:blank:]]*")
	if (RSTART) {
		indent=substr(line_text, RSTART, RLENGTH)
		sub("^[-+]", " ", indent)
	}

	return indent
}

# is_new_diff_file(line_text)
#
# Parameters:
#   1>  line_text  :  line text      (string)
#   returns        :  diff file name (string)
#
# Description
#   Checks if the line contains the start of a new diff file
#   block, in a patch file. Returns null if the line is not
#   the start of a new diff file.
function is_new_diff_file(line_text,
	array_line_fields, diff_file, field_count)
{
	if (line_text ~ "^diff ") {
		field_count = split(line_text, array_line_fields)
		diff_file=array_line_fields[field_count]
		sub("^[^/]*", "", diff_file)
	}

	return diff_file
}

# is_new_hunk(line_text)
#
# Parameters:
#   1>  line_text  :  line text      (string)
#   returns        :  0=false 1=true (boolean)
#
# Description
#   Checks if line text is the start of a diff hunk,
#   in a patch file.
function is_new_hunk(line_text)
{
	return (line_text ~ "^@@[[:blank:]][-][[:digit:]][[:digit:]]*,[[:digit:]][[:digit:]]*[[:blank:]][+][[:digit:]][[:digit:]]*,[[:digit:]][[:digit:]]*[[:blank:]]@@( |$)")
}

# preprocess_patch_file_line(line_text, diff_array)
#
# Parameters:
#   1 >  line_text          :  (patch file) line text            (string)
#   2<>  diff_array         :  array of (patch file) diff data   (string/integer array)
#
# Description
#   Updates the diff data for the specified patch file line text.
#   The diff data array stores:
#     * "file"  : file name (diff'd file)
#     * "ihunk" : current hunk sequence number
#     * "idiff" : current diff (change within a hunk) sequence number
function preprocess_patch_file_line(line_text, diff_array,
	new_diff_file)
{
	if (new_diff_file = is_new_diff_file(line_text)) {
		diff_array["file"] = new_diff_file
		diff_array["idiff"]=1
		diff_array["ihunk"]=0
	}
	else if (is_new_hunk(line_text)) {
		++diff_array["ihunk"];
		diff_array["idiff"]=1
	}
}

# preprocess_diff_file(line, diff_array)
#
# Parameters:
#   1 >  line          :  (patch file) line number            (integer)
#   2<>  diff_array    :  array of (patch file) diff data     (string/integer array)
#
# Description
#   Updates the diff data for the specified patch file hunk (first line).
#   The diff data array stores:
#     * "exit start line" : current hunk start line (for error messages)
#     * "exit file"       : currently processed diff file name (for error messages)
#     * "file"            : currently processed diff file name
function preprocess_diff_file(line, diff_array,
	new_diff_file)
{
	diff_array["exit start line"]=diff_array["exit start line"] ? diff_array["exit start line"] : line
	diff_array["exit file"]=diff_array["file"]
}

# preprocess_diff_file_hunk(line, file_array, diff_array)
#
# Parameters:
#   1 >  line          :  (patch file) line number             (integer)
#   2 >  file_array    :  array of (patch file) line text      (string array)
#   3<>  diff_array    :  array of (patch file) diff data      (string/integer array)
#
# Description
#   Updates the diff exit data for the specified patch file hunk (within the current diff file).
#   The diff data array stores:
#     * "exit start line" : current hunk start line (for error messages)
#     * "exit ihunk"      : current hunk sequence number (for error messages)
#     * "ihunk"           : current hunk sequence number
function preprocess_diff_file_hunk(line, file_array, diff_array,
	new_diff_file)
{
	diff_array["exit ihunk"]=diff_array["ihunk"]
	if (is_new_hunk(file_array[line]))
		diff_array["exit start line"]=line
}

# change_array_entry_diff(file_array, target_line, line_text)
#
# Parameters:
#   1>  file_array          :  array of (patch file) line text         (string array)
#   2>  target_line         :  line number to change a hunk diff range (integer)
#   3>  array_diff_offsets  :  offsets to the range(s) for a diff hunk (integer array)
#
# Description
#   Offsets the diff range (before/after: line and line count) with
#   the specified values in array_diff_offsets. The target line is
#   altered in file_array.
function change_array_entry_diff(file_array, target_line, array_diff_offsets,
	count, diff_length, diff_target_line, diff_target_line_block, i, idx)
{
	count=split("[-] [+]", array_diff_target_line_blocks)
	for ( i = 1 ; i <= count ; ++i ) {
		diff_target_line_block=("[[:blank:]]" array_diff_target_line_blocks[i] "[[:digit:]][[:digit:]]*,[[:digit:]][[:digit:]]*[[:blank:]]")
		match(file_array[target_line], diff_target_line_block)
		if (RSTART) {
			diff_target_line = diff_length = substr(file_array[target_line], RSTART+2, RLENGTH-3)
			sub(",.*$", "", diff_target_line)
			sub("^.*,", "", diff_length)
			diff_target_line += array_diff_offsets[++idx]+0
			diff_length += array_diff_offsets[++idx]+0
			file_array[target_line] = (substr(file_array[target_line], 1, RSTART+1) diff_target_line "," diff_length substr(file_array[target_line], RSTART+RLENGTH-1))
		}
	}
}

# insert_array_entry(file_array, target_line, line_text)
#
# Parameters:
#   1>  file_array  :  array of (patch file) line text (string array)
#   2>  target_line :  line number to insert at        (integer)
#   3>  line_text   :  text of new line to insert      (string)
#
# Description
#   Inserts line text at target line entry, in the specified
#   array. Current array entry, at the target line entry,
#   and subsequent lines are moved up one place in the array.
function insert_array_entry(file_array, target_line, line_text,
		line)
{
	for (line = file_array[0] ; line >= target_line ; --line) {
		if (file_array[line])
			file_array[line+1] = file_array[line]
	}
	file_array[target_line] = line_text
	++file_array[0]
}

# print_file(file_array, file_path)
#
# Parameters:
#   1>  file_array :  array of (patch file) line text (string array)
#   2>  file_path  :  file to redirect awk output to  (string)
#
# Description
#   Dump contents of specified array to a system
#   file path.
function print_file(file_array, file_path,
		line)
{
	for (line = 1 ; line <= file_array[0] ; ++line) {
		if ((line in file_array) && (file_array[line] != ""))
			print file_array[line] >file_path
	}
}

