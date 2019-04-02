#!/usr/bin/env awk

# text2regexp(text)
#
# Parameters:
#   file_name       :  patch file being processed by awk           (string,  global)
#   exit_code       :  exit code for this awk script               (integer, global)
#   exit_diff_file  :  diff file being processed in patch          (string,  global)
#   exit_hunk       :  hunk number being processed in diff file    (integer, global)
#   exit_start_line :  start line, in patch file, for failed block (integer, global)
#   exit_end_line   :  end line, in patch file, for failed block   (integer, global)
#
# Description
#   Dumps a fixed format error message to stderr. An error will occur:
#   * when the script is unable to match a search line, in the current diff hunk
#   * when a diff file is not found
#   in the current patch file.
function dump_error()
{
	if (exit_code == 255)
		return

	printf("%s: file: '%s' hunk: %d [%d] (lines: %04d-%04d) failed\n",
			file_name, exit_diff_file, exit_hunk, exit_code, exit_start_line, exit_end_line) >"/dev/stderr"
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

# preprocess_patch_file_line(file_array, target_line, line_text)
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

