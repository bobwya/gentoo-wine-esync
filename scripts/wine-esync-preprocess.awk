#!/usr/bin/env awk

function process_patch_file_0001(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/configure") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 18) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ "sys/inotify.h \\\\$") {
						sub(text2regexp("sys/inotify.h"), "sys/ioctl.h", file_array[line])
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ "poll \\\\$") {
						line_text = (indent "pipe2 \\")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ "popen \\\\$") {
						delete file_array[line]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/configure.ac") && (complete >= 2)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 18) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ "sys/inotify.h \\\\$") {
						sub(text2regexp("sys/inotify.h"), "sys/ioctl.h", file_array[line])
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ "poll \\\\$") {
						line_text = (indent "pipe2 \\")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ "popen \\\\$") {
						delete file_array[line]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0001(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/configure") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("-243 0 -243 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("-137 0 -137 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 3) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("-137 0 -137 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/configure.ac") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("-3 0 -3 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 2) && (complete >= 4)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("47 0 47 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 3) && (complete >= 5)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("47 0 47 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 6) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0002(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ REQ_set_job_limits,$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ REQ_terminate_job,$")) {
						line_text=(indent "REQ_suspend_process,")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "REQ_resume_process,")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_limits_request set_job_limits_request;$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct terminate_job_request terminate_job_request;$")) {
						line_text=(indent "struct suspend_process_request suspend_process_request;")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "struct resume_process_request resume_process_request;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
					if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_limits_reply set_job_limits_reply;$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct terminate_job_reply terminate_job_reply;$")) {
						line_text=(indent "struct suspend_process_reply suspend_process_reply;")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "struct resume_process_reply resume_process_reply;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ "^ #define SERVER_PROTOCOL_VERSION [[:digit:]][[:digit:]][[:digit:]]$") {
						file_array[line] = indent
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/esync.c") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1)  {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 11) {
						diff_array["idiff"]+=2
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 0 0 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+ no_open_file, /* open_file */$")) {
						line_text="+    no_kernel_obj_list,        /* get_kernel_obj_list */"
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/protocol.def") && (complete >= 4)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (!staging && (esync_rebase_index <= 16)) {
						diff_array["idiff"]+=2
					}
					else if (is_new_hunk(file_array[line])) {
						split("113 3 113 3", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+@END$")) {
						indent = " "
						line_text = (indent "")
						insert_array_entry(file_array, ++line, line_text)
						insert_array_entry(file_array, ++line, line_text)
						if (staging)	line_text = (indent "/* Return system information values */")
						else			line_text = (indent "/* Suspend a process */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/request.h") && (complete >= 5)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ DECL_HANDLER(set_job_limits);$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ DECL_HANDLER(terminate_job);$")) {
						line_text=(indent "DECL_HANDLER(suspend_process);")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "DECL_HANDLER(resume_process);")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (req_handler)req_set_job_limits,$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (req_handler)req_terminate_job,$")) {
						line_text=(indent "(req_handler)req_suspend_process,")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "(req_handler)req_resume_process,")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (is_new_hunk(file_array[line])) {
						sub(text2regexp("C_ASSERT( sizeof(struct set_job_completion_port_request) == 32 );"),
							"C_ASSERT( FIELD_OFFSET(struct suspend_process_request, handle) == 12 );",
							file_array[line])
						indent=" "
						file_array[++line] = (indent "C_ASSERT( sizeof(struct suspend_process_request) == 16 );")
						file_array[++line] = (indent "C_ASSERT( FIELD_OFFSET(struct resume_process_request, handle) == 12 );")
						file_array[++line] = (indent "C_ASSERT( sizeof(struct resume_process_request) == 16 );")
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
			}
		}
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 8)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1)  {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (is_new_hunk(file_array[line])) {
						sub(text2regexp("static void dump_terminate_job_request( const struct terminate_job_request *req"),
										"static void dump_resume_process_request( const struct resume_process_request *r",
							file_array[line])
						sub(text2regexp("fprintf( stderr, \", status=%d\", req->status );"),
										"fprintf( stderr, \" handle=%04x\", req->handle );",
							file_array[++line])
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index != 7) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"),
											 "(dump_func)dump_exec_process_request,",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (dump_func)dump_set_job_limits_request,$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (dump_func)dump_terminate_job_request,$")) {
						line_text=(indent "(dump_func)dump_suspend_process_request,")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "(dump_func)dump_resume_process_request,")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ \"set_job_limits\",$")) {
						delete file_array[line]
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ \"terminate_job\",$")) {
						line_text=(indent "\"suspend_process\",")
						insert_array_entry(file_array, ++line, line_text)
						line_text=(indent "\"resume_process\",")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 11) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0002(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/esync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 12) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 0 0 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+ no_open_file, /* open_file */$")) {
						line_text = ("+" substr(indent, 2) "no_alloc_handle,		   /* alloc_handle */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0003(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/server.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if ((diff_array["idiff"] == 1) && (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(server);$"))) {
					line_text = (" WINE_DECLARE_DEBUG_CHANNEL(winediag);")
					file_array[++line] = line_text
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0006(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/om.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if ((diff_array["idiff"] == 1) && (file_array[line] ~ "^ #include \"wine/server.h\"$")) {
					line_text = " "
					file_array[++line] = line_text
					line_text = (indent "WINE_DEFAULT_DEBUG_CHANNEL(ntdll);")
					file_array[++line] = line_text
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0006(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/om.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if ((diff_array["idiff"] == 1) && (file_array[line] ~ "^ #include \"wine/exception.h\"$")) {
					line_text = (indent "#include \"wine/unicode.h\"")
					file_array[++line] = line_text
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0007(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/esync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] <= 3) {
					if (sub(text2regexp("DPRINTF"), "TRACE", file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0009(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/sync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index == 9) {
						++diff_array["idiff"]
					}
					else if (is_new_hunk(file_array[line])) {
						sub(text2regexp("NTSTATUS WINAPI NtSetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"), "NTSTATUS WINAPI NtOpenEvent( HANDLE *handle, ACCESS_MASK access, const OBJECT_ATT", file_array[line])
						split("+57 0 +57 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if ((esync_rebase_index == 9) && !staging) {
						++diff_array["idiff"]
					}
					else if (file_array[line-1] ~ text2regexp(" @@ NTSTATUS WINAPI *")) {
						line_text = (indent "NTSTATUS WINAPI NtSetEvent( HANDLE handle, LONG *prev_state )")
						insert_array_entry(file_array, line, line_text)
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 3) {
					if ((esync_rebase_index == 9) && !staging) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ NTSTATUS ret;$")) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 4) {
					if (file_array[line] ~ text2regexp("/* FIXME: set NumberOfThreadsReleased */$")) {
						if ((esync_rebase_index == 9) && !staging) {
							++diff_array["idiff"]
							++complete
						}
						else {
							delete file_array[line]
							delete file_array[++line]
							++line
							line_text=(indent "{")
							insert_array_entry(file_array, ++line, line_text)
							indent=(indent "    ")
							line_text=(indent "req->handle = wine_server_obj_handle( handle );")
							insert_array_entry(file_array, ++line, line_text)
							++diff_array["idiff"]
							++complete
						}
					}
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0010(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/sync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 8) {
						diff_array["idiff"] += 4
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						if ((esync_rebase_index >= 10) || ((esync_rebase_index == 9) && staging))
							sub(text2regexp("NTSTATUS WINAPI NtResetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"), "NTSTATUS WINAPI NtSetEvent( HANDLE handle, LONG *prev_state )", file_array[line])
						else
							sub(text2regexp("NTSTATUS WINAPI NtResetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"), "NTSTATUS WINAPI NtResetEvent( HANDLE handle, LONG *prev_state )", file_array[line])
						split("+55 0 +55 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						if ((esync_rebase_index >= 10) || ((esync_rebase_index == 9) && staging)) {
							line_text=" NTSTATUS WINAPI NtResetEvent( HANDLE handle, LONG *prev_state )"
							insert_array_entry(file_array, ++line, line_text)
						}
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if ((esync_rebase_index <= 8) || ((esync_rebase_index == 9) && !staging)) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("NTSTATUS ret;$")) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 3) {
					if ((esync_rebase_index <= 8) || ((esync_rebase_index == 9) && !staging)) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("/* resetting an event can't release any thread... */$"), "SERVER_START_REQ( event_op )", file_array[line])) {
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 4) {
					if (file_array[line] ~ text2regexp("if (NumberOfThreadsReleased) *NumberOfThreadsReleased = 0;$")) {
						if ((esync_rebase_index == 9) && !staging) {
							line_text="if (prev_state) *prev_state = 0;"
							file_array[line] = (indent line_text)
							file_array[++line] = " "
						}
						else {
							line_text="{"
							file_array[line] = (indent line_text)
							line_text= "req->handle = wine_server_obj_handle( handle );"
							indent=(indent "    ")
							file_array[++line] = (indent line_text)
						}
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0011(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/sync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (sub(text2regexp("NTSTATUS WINAPI NtPulseEvent( HANDLE handle, PULONG PulseCount )$"),
										"NTSTATUS WINAPI NtPulseEvent( HANDLE handle, LONG *prev_state )",
							file_array[line])) {
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ if (PulseCount)")) {
						line_text=(indent "SERVER_START_REQ( event_op )")
						file_array[line] = line_text
						line_text=(indent "{")
						file_array[++line] = line_text
						indent=(indent "    ")
						line_text=(indent "req->handle = wine_server_obj_handle( handle );")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0013(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/named_pipe.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (1) {
						++diff_array["idiff"]
						++complete
					}
					else if (sub(text2regexp("named_pipe_device_get_fd, /* get_fd */"), "no_get_fd,						/* get_fd */", file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0014(file_array, diff_array,
	complete, indent, line, line_count, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ REQ_set_job_completion_port,$")) {
						line_text=(indent "REQ_suspend_process,")
						file_array[line] = line_text
						line_text=(indent "REQ_resume_process,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_completion_port_request set_job_completion_port_request;$")) {
						line_text=(indent "struct suspend_process_request suspend_process_request;")
						file_array[line] = line_text
						line_text=(indent "struct resume_process_request resume_process_request;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						saved_line=line
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_completion_port_reply set_job_completion_port_reply;$")) {
						line_text=(indent "struct suspend_process_reply suspend_process_reply;")
						file_array[line] = line_text
						line_text=(indent "struct resume_process_reply resume_process_reply;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ "^[- ]#define SERVER_PROTOCOL_VERSION [[:digit:]][[:digit:]][[:digit:]]$") {
						# patch: 0014-server-Add-a-request-to-get-the-eventfd-file-descrip.patch
						# for esync release tarball: esyncb4478b7.tgz
						# has invalid line counts... Fix this!
						file_array[line] = " "
						++line
						line_count=(esync_rebase_index <= 7) ? 1 : 0
						while(!is_new_diff_file(file_array[line])) {
							delete file_array[line]
							++line
							line_count-=1
						}
						if (saved_line) {
							split(("371 " line_count " 371 " line_count), array_diff_lines)
							change_array_entry_diff(file_array, saved_line, array_diff_lines)
						}
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/protocol.def") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (!staging && (esync_rebase_index <= 16)) {
						diff_array["idiff"]+=2
					}
					else if (is_new_hunk(file_array[line])) {
						split("113 3 113 3", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+@END$")) {
						indent = " "
						line_text = (indent "")
						insert_array_entry(file_array, ++line, line_text)
						insert_array_entry(file_array, ++line, line_text)
						if (staging)	line_text = (indent "/* Return system information values */")
						else			line_text = (indent "/* Suspend a process */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/request.h") && (complete >= 4)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ DECL_HANDLER(set_job_completion_port);$")) {
						line_text=(indent "DECL_HANDLER(suspend_process);")
						file_array[line] = line_text
						line_text=(indent "DECL_HANDLER(resume_process);")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (req_handler)req_set_job_completion_port,$")) {
						line_text=(indent "(req_handler)req_suspend_process,")
						file_array[line] = line_text
						line_text=(indent "(req_handler)req_resume_process,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 6)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1)  {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index != 7) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"),
											 "(dump_func)dump_exec_process_request,",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (dump_func)dump_set_job_completion_port_request,$")) {
						line_text=(indent "(dump_func)dump_suspend_process_request,")
						file_array[line] = line_text
						line_text=(indent "(dump_func)dump_resume_process_request,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ \"set_job_completion_port\",$")) {
						line_text=(indent "\"suspend_process\",")
						file_array[line] = line_text
						line_text=(indent "\"resume_process\",")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 9) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0014(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (1) {
						diff_array["idiff"] += 3
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("-401 0 -401 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (sub(text2regexp("struct set_job_completion_port_reply set_job_completion_port_reply;$"),
						   "struct suspend_process_reply suspend_process_reply;",
						   file_array[line])) {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (sub(text2regexp("struct terminate_job_reply terminate_job_reply;$"),
							"struct resume_process_reply resume_process_reply;",
							file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0015(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/process.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 17) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ static void process_poll_event( struct fd *fd, int event );$")) {
						line_text = (indent "static struct list *process_get_kernel_obj_list( struct object *obj );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 17) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (file_array[line] ~ text2regexp("^+ process->esync_fd = -1;$")) {
						line_text = (indent "list_init( &process->kernel_object );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ list_init( &process->asyncs );$")) {
						delete file_array[line]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 5) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 6) {
						++diff_array["idiff"]
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ set_fd_events( process->msg_fd, POLLIN ); /* start listening to events */$")) {
						line_text = (indent "/* create the main thread */")
						file_array[line] = line_text
						line_text = (indent "if (pipe( request_pipe ) == -1)")
						file_array[++line] = line_text
						line_text = (indent "{")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/process.h") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 17) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ const struct rawinput_device *rawinput_kbd;   /* rawinput keyboard device, if any */$")) {
						line_text = (indent "struct list          kernel_object;   /* list of kernel object pointers */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0015(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/process.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (sub(text2regexp("^ static unsigned int process_map_access( struct object *obj, unsigned int access );$"),
							" static struct security_descriptor *process_get_sd( struct object *obj );",
							file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 5) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ if (!token_assign_label( process->token, security_high_label_sid ))$")) {
						line_text = (indent "}")
						file_array[line] = line_text
						line_text = (indent "if (!process->handles || !process->token) goto error;")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0017(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/event.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						diff_array["idiff"]+=3
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 2 0 2", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ struct object  obj; /* object header */$")) {
						line_text = (indent "struct list    kernel_object;   /* list of kernel object pointers */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ text2regexp("^ static int event_signal( struct object *obj, unsigned int access);$")) {
						line_text = (indent "static struct list *event_get_kernel_obj_list( struct object *obj );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 3) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 11) {
						++diff_array["idiff"]
					}
					else if (is_new_hunk(file_array[line])) {
						split("2 -1 2 -1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ no_open_file, /* open_file */$")) {
						if ((esync_rebase_index >= 13) || (staging && (esync_rebase_index == 12)))
							line_text = "event_get_kernel_obj_list, /* get_kernel_obj_list */"
						else if (esync_rebase_index == 12)
							line_text = "no_kernel_obj_list,        /* get_kernel_obj_list */"
						file_array[line] = (indent line_text)
					}
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 4) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						++diff_array["idiff"]
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ /* initialize it if it didn't already exist */$")) {
						line_text = (indent "list_init( &event->kernel_object );")
						file_array[line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 7) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (sub(text2regexp("struct keyed_event *create_keyed_event( struct object *root, const struct unicode_str *name,$"),
											 "static struct list *event_get_kernel_obj_list( struct object *obj )",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ unsigned int attr, const struct security_descriptor *sd )$")) {
						delete file_array[line]
						indent="     "
						line_text = (indent "struct event *event = (struct event *)obj;")
						line+=2
						insert_array_entry(file_array, line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0017(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/event.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ no_open_file, /* open_file */$")) {
						line_text = (indent "no_alloc_handle,           /* alloc_handle */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0020(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (staging || (esync_rebase_index >= 9)) {
						if (is_new_hunk(file_array[line])) {
							delete file_array[++line]
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (staging || (esync_rebase_index >= 9)) {
						if (file_array[line] ~ text2regexp("^ static void dump_thread( struct object *obj, int verbose );$")) {
							line_text = (indent "static struct object_type *thread_get_type( struct object *obj );")
							insert_array_entry(file_array, ++line, line_text)
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (esync_rebase_index >= 16) {
						if (sub(text2regexp("static void destroy_thread( struct object *obj );$"), "static struct list *thread_get_kernel_obj_list( struct object *obj );", file_array[line]))
							++diff_array["idiff"]
					}
					else {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 15) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ timeout_t creation_time; /* Thread creation time */$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ struct token *token; /* security token associated with this thread */$")) {
						line_text = (indent "struct list            kernel_object; /* list of kernel object pointers */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0020(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^+ thread->esync_fd = -1;$")) {
						line_text = (indent "thread->exit_poll       = NULL;")
						file_array[++line] = line_text
						line_text = (indent "thread->shm_fd          = -1;")
						file_array[++line] = line_text
						line_text = (indent "thread->shm             = NULL;")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 5) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ if (thread->id) free_ptid( thread->id );$")) {
						line_text = (indent "if (thread->exit_poll) remove_timeout_user( thread->exit_poll );")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 6) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 8) && sub(text2regexp("return (mythread->state == TERMINATED);$"), "return (mythread->state == TERMINATED \\&\\& !mythread->exit_poll);", file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
					else if (sub(text2regexp("return (mythread->state == TERMINATED);$"),
											 "return mythread->state == TERMINATED \\&\\& !mythread->exit_poll;",
								 file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^+ int esync_fd; /* esync file descriptor (signalled on exit) */$")) {
						line_text = (indent "struct timeout_user   *exit_poll;     /* poll if the thread/process has exited already */")
						file_array[++line] = line_text
						line_text = (indent "int                    shm_fd;        /* file descriptor for thread local shared memory */")
						file_array[++line] = line_text
						line_text = (indent "shmlocal_t            *shm;           /* thread local shared memory pointer */")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0022(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/queue.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ struct thread_input *input; /* thread input descriptor */$")) {
						delete file_array[line]
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ timeout_t last_get_msg; /* time of last get message call */$")) {
						line_text = (indent "unsigned int           ignore_post_msg; /* ignore post messages newer than this unique id */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
			else if ((diff_array["ihunk"] == 5) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ queue->input = (struct thread_input *)grab_object( input );$")) {
						delete file_array[line]
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ queue->last_get_msg = current_time;$")) {
						line_text = (indent "queue->ignore_post_msg = 0;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (sub(text2regexp("if (new_input) release_object( new_input );$"),
							"if (new_input)",
							file_array[line])) {
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
			else if ((diff_array["ihunk"] == 6) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ queue->wake_bits &= ~bits;$")) {
						delete file_array[line-1]
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ queue->changed_bits &= ~bits;$")) {
						line_text = (indent "update_shm_queue_bits( queue );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 3) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0023(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/ntdll.spec") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index != 0) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						if (staging)
							split("15 1 15 1", array_diff_lines)
						else
							split("-13 1 -13 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+@ cdecl __wine_esync_set_queue_fd(long)$")) {
						if (staging)	line_text=" @ cdecl __wine_user_shared_data()"
						else			line_text=" @ cdecl __wine_init_windows_dir(wstr wstr)"
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
		}
		else if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 13) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						indent="     "
						line_text=(indent "thread_data->reply_fd   = -1;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ thread_data->debug_info = &debug_info;$")) {
						delete file_array[line]
						++line
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0023(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/ntdll.spec") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if ((diff_array["idiff"] == 1) && is_new_hunk(file_array[line])) {
					split("0 3 0 3", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++diff_array["idiff"]
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+@ cdecl __wine_esync_set_queue_fd(long)$")) {
						indent = " "
						line_text = indent
						insert_array_entry(file_array, ++line, line_text)
						line_text =  (indent "# User shared data")
						insert_array_entry(file_array, ++line, line_text)
						line_text =  (indent "@ cdecl __wine_user_shared_data()")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
		}
		else if (diff_array["file"] == "/dlls/ntdll/ntdll_misc.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ int wait_fd[2]; /* fd for sleeping server requests */$")) {
						delete file_array[line]
						++diff_array["idiff"]
						diff_array["exit end line"]=line
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+ int esync_queue_fd;/* fd to wait on for driver events */")) {
						line_text = (indent "void              *pthread_stack; /* pthread stack */")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
						++complete
						diff_array["exit end line"]=line
					}
				}
			}
		}
		else if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 4) {
						diff_array["idiff"] += 3
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("171 0 171 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (sub(text2regexp("pthread_attr_init( &attr );$"),
						   "pthread_attr_init( \\&pthread_attr );",
						   file_array[line])) {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (sub(text2regexp("pthread_attr_setstack( &attr, teb->DeallocationStack,$"),
						   "pthread_attr_setstack( \\&pthread_attr, teb->DeallocationStack,",
						   file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 3) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0024(file_array, diff_array,
	complete, indent, line)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/esync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 7) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] <= 3) {
					if (sub(text2regexp("DPRINTF"), "TRACE", file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/process.c") && (complete >= 1)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 17) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ static void process_poll_event( struct fd *fd, int event );$")) {
						line_text = (indent "static struct list *process_get_kernel_obj_list( struct object *obj );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/protocol.def") && (complete >= 2)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (!staging && (esync_rebase_index <= 16)) {
						diff_array["idiff"]+=2
					}
					else if (is_new_hunk(file_array[line])) {
						split("113 3 113 3", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^+};$")) {
						indent = " "
						line_text = (indent "")
						insert_array_entry(file_array, ++line, line_text)
						insert_array_entry(file_array, ++line, line_text)
						if (staging)	line_text = (indent "/* Return system information values */")
						else			line_text = (indent "/* Suspend a process */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/thread.c") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (staging || (esync_rebase_index >= 9)) {
						if (is_new_hunk(file_array[line])) {
							delete file_array[++line]
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (staging || (esync_rebase_index >= 9)) {
						if (file_array[line] ~ text2regexp("static void dump_thread( struct object *obj, int verbose );$")) {
							line_text=(indent "static struct object_type *thread_get_type( struct object *obj );")
							insert_array_entry(file_array, ++line, line_text)
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (esync_rebase_index >= 16) {
						if (sub(text2regexp("static void destroy_thread( struct object *obj );$"),
											"static struct list *thread_get_kernel_obj_list( struct object *obj );",
								file_array[line])) {
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 2) && (complete >= 4)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (!staging) {
						diff_array["idiff"] += 1
						++complete
					}
					else if ((esync_rebase_index <= 8) && sub(text2regexp("return (mythread->state == TERMINATED);$"),
																		  "return (mythread->state == TERMINATED \\&\\& !mythread->exit_poll);",
															  file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
					else if (sub(text2regexp("return (mythread->state == TERMINATED);$"),
											 "return mythread->state == TERMINATED \\&\\& !mythread->exit_poll;",
								 file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 5)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index == 7) {
						if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"),
											"(dump_func)dump_exec_process_request,",
								file_array[line])) {
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 6) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0024(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/process.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (sub(text2regexp("static unsigned int process_map_access( struct object *obj, unsigned int access );$"),
							"static struct security_descriptor *process_get_sd( struct object *obj );",
							file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0025(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/device.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 11) {
						diff_array["idiff"]+=4
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("8 0 8 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ struct object obj; /* object header */$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (sub(text2regexp("struct list devices;"), "& ", file_array[line])) {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 4) {
					if (sub(text2regexp("struct list requests;"), "& ", file_array[line])) {
						line_text=(indent "struct wine_rb_tree    kernel_objects; /* map of objects that have client side pointer associated */")
						insert_array_entry(file_array, ++line, line_text)
						if (sub(text2regexp("int esync_fd;"), "& ", file_array[++line])) {
							++diff_array["idiff"]
							++complete
						}
					}
				}
			}
			else if ((diff_array["ihunk"] == 6) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						++diff_array["idiff"]
						++complete
					}
					else if (sub("^ }$", " ", file_array[line])) {
						line_text=(indent "    while ((ptr = list_head( &manager->requests )))")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
			}
			else if ((diff_array["ihunk"] == 7) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 11) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("8 0 8 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("list_init( &manager->requests );$")) {
						line_text = (indent "wine_rb_init( &manager->kernel_objects, compare_kernel_object );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			else if ((diff_array["ihunk"] == 8) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						diff_array["idiff"]+=2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("8 0 8 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("list_init( &irp->mgr_entry );$")) {
						line_text = (indent "if (!irp->file) release_object( irp ); /* no longer on manager queue */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			diff_array["exit end line"]=line
		}
	}

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0025(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/device.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 6) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("69 0 69 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						indent="         "
						line_text = (indent "grab_object( &device->obj );")
						file_array[++line] = line_text
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ delete_device( device );$")) {
						line_text = (indent "release_object( &device->obj );")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			diff_array["exit end line"]=line
		}
	}

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0033(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ REQ_set_job_completion_port,$")) {
						line_text=(indent "REQ_suspend_process,")
						file_array[line] = line_text
						line_text=(indent "REQ_resume_process,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_completion_port_request set_job_completion_port_request;$")) {
						line_text=(indent "struct suspend_process_request suspend_process_request;")
						file_array[line] = line_text
						line_text=(indent "struct resume_process_request resume_process_request;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 8) {
						++diff_array["idiff"]
					}
					else if (is_new_hunk(file_array[line])) {
						split("308 -3 308 -3", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ struct set_job_completion_port_reply set_job_completion_port_reply;$")) {
						line_text=(indent "struct suspend_process_reply suspend_process_reply;")
						file_array[line] = line_text
						line_text=(indent "struct resume_process_reply resume_process_reply;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (esync_rebase_index >= 8) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION ")) {
						while(!is_new_diff_file(file_array[line]))
							delete file_array[line++]
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/request.h") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ DECL_HANDLER(set_job_completion_port);$")) {
						line_text=(indent "DECL_HANDLER(suspend_process);")
						file_array[line] = line_text
						line_text=(indent "DECL_HANDLER(resume_process);")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (req_handler)req_set_job_completion_port,$")) {
						line_text=(indent "(req_handler)req_suspend_process,")
						file_array[line] = line_text
						line_text=(indent "(req_handler)req_resume_process,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 5)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ (dump_func)dump_set_job_completion_port_request,$")) {
						line_text=(indent "(dump_func)dump_suspend_process_request,")
						file_array[line] = line_text
						line_text=(indent "(dump_func)dump_resume_process_request,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ \"set_job_completion_port\",$")) {
						line_text=(indent "\"suspend_process\",")
						file_array[line] = line_text
						line_text=(indent "\"resume_process\",")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete != 7) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0041(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	if (esync_rebase_index <= 10)
		diff_offset=staging ? -28 : -58
	else
		diff_offset=staging ? 0 : 0

	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split((diff_offset " 0 " diff_offset " 0"), array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split((diff_offset " 0 " diff_offset " 0"), array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0041(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/main.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("1 1 1 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ init_signals();$")) {
						line_text = (indent "init_scheduler();")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0042(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 1) {
						++diff_array["idiff"]
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(thread);$")) {
						line_text=(" " "WINE_DECLARE_DEBUG_CHANNEL(relay);")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$")) {
						line_text=" "
						file_array[++line] = line_text
						line_text = (indent "return exe_file;")
						file_array[++line] = line_text
						while(file_array[++line] ~ "^[[:blank:]]*$")
							delete file_array[line]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0042(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("163 0 163 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ fill_cpu_info();$")) {
						line_text = (indent "__wine_user_shared_data();")
						file_array[line-1] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0045(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/esync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] <= 3) {
					if (sub(text2regexp("DPRINTF"), "TRACE", file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 13) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						indent="     "
						line_text=(indent "thread_data->wait_fd[0] = -1;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
					diff_array["exit end line"]=line
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ thread_data->debug_info = &debug_info;$")) {
						delete file_array[line]
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
		else if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 4) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("283 -2 283 -2", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION ")) {
						file_array[line] = " "
						++line
						while(!is_new_diff_file(file_array[line]))
							delete file_array[line++]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 16) {
						if (file_array[line] ~ text2regexp("^ timeout_t exit_time; /* Thread exit time */$")) {
							delete file_array[line]
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index >= 16) {
						if (file_array[line] ~ text2regexp("^ struct token *token; /* security token associated with this thread */$")) {
							line_text = (indent "struct list            kernel_object; /* list of kernel object pointers */")
							insert_array_entry(file_array, ++line, line_text)
							++diff_array["idiff"]
						}
					}
					else {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/trace.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 4)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index != 7) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"),
											 "(dump_func)dump_exec_process_request,",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 5) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0045(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/ntdll_misc.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ int esync_queue_fd;/* fd to wait on for driver events */$")) {
						line_text = (indent "void              *pthread_stack; /* pthread stack */")
						insert_array_entry(file_array, line, line_text)
						++line
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("171 0 171 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 4) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (sub(text2regexp("pthread_attr_init( &attr );$"),
								 "pthread_attr_init( \\&pthread_attr );",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (sub(text2regexp("pthread_attr_setstack( &attr, teb->DeallocationStack,$"),
							"pthread_attr_setstack( \\&pthread_attr, teb->DeallocationStack,",
							file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^+ thread->esync_apc_fd = -1;$")) {
						line_text="thread->exit_poll       = NULL;"
						file_array[++line] = (indent line_text)
						line_text="thread->shm_fd          = -1;"
						file_array[++line] = (indent line_text)
						line_text="thread->shm             = NULL;"
						file_array[++line] = (indent line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^+ int esync_apc_fd; /* esync apc fd (signalled when APCs are present) */$")) {
						line_text="struct timeout_user   *exit_poll;     /* poll if the thread/process has exited already */"
						file_array[++line] = (indent line_text)
						line_text="int                    shm_fd;        /* file descriptor for thread local shared memory */"
						file_array[++line] = (indent line_text)
						line_text="shmlocal_t            *shm;           /* thread local shared memory pointer */"
						file_array[++line] = (indent line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0048(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/kernel32/tests/sync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (sub(text2regexp("ERROR_INVALID_PARAMETER"), "ERROR_FILE_NOT_FOUND", file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0059(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/kernel32/tests/sync.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ START_TEST(sync)$")) {
						line_text = (indent "static void test_crit_section(void)")
						file_array[line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ char **argv;$")) {
						indent = "     "
						line_text = (indent "CRITICAL_SECTION cs;")
						file_array[line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ test_apc_deadlock();$")) {
						line_text = (indent "test_crit_section();")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0064(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/fd.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 9) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ apc_param_t comp_key; /* completion key to set in completion events */$")) {
						line_text = (indent "unsigned int         comp_flags;  /* completion flags */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			else if ((diff_array["ihunk"] == 4) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 9) {
						diff_array["idiff"] += 2
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ fd->fs_locks = 1;$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ fd->completion = NULL;$")) {
						line_text = (indent "fd->comp_flags = 0;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 5) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 9) {
						diff_array["idiff"] += 1
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ fd->poll_index = -1;$")) {
						line_text = (indent "fd->completion = NULL;")
						file_array[line] = line_text
						line_text = (indent "fd->comp_flags = 0;")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 6) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 8) {
						diff_array["idiff"] += 1
						++complete
					}
					else if (file_array[line] ~ text2regexp("fd->signaled = signaled;$")) {
						line_text = (indent "if (fd->comp_flags & FILE_SKIP_SET_EVENT_ON_HANDLE) return;")
						file_array[line-1] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 4) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0074(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$")) {
						line_text = " "
						if (esync_rebase_index == 6)
							file_array[++line] = line_text
						else
							insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0074(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/dlls/ntdll/thread.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ fill_cpu_info();$")) {
						line_text = (indent "__wine_user_shared_data();")
						file_array[line-1] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0077(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/request.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 16) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("C_ASSERT( sizeof(struct terminate_job_request) == 24 );$"),
								 "C_ASSERT( sizeof(struct resume_process_request) == 16 );",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_0079(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/include/wine/server_protocol.h") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 4) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("306 -2 306 -2", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION ")) {
						file_array[line] = " "
						++line
						while(!is_new_diff_file(file_array[line]))
							delete file_array[line++]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 1)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index != 7) {
						++diff_array["idiff"]
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"),
											 "(dump_func)dump_exec_process_request,",
								 file_array[line])) {
						++diff_array["idiff"]
					}
				}
			}
			else if (diff_array["ihunk"] == 4) {
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index >= 6) {
						++diff_array["idiff"]
						++complete
					}
					else if ((diff_array["idiff"] == 1) && (file_array[line] ~ text2regexp("^-- $"))) {
						line_text="@@ -5460,4 +5554,5 @@ static const struct"
						insert_array_entry(file_array, line, line_text)
						line_text="     { \"INVALID_OWNER\",               STATUS_INVALID_OWNER },"
						insert_array_entry(file_array, ++line, line_text)
						line_text="     { \"INVALID_PARAMETER\",           STATUS_INVALID_PARAMETER },"
						insert_array_entry(file_array, ++line, line_text)
						line_text="+    { \"INVALID_PARAMETER_4\",         STATUS_INVALID_PARAMETER_4 },"
						insert_array_entry(file_array, ++line, line_text)
						if (esync_rebase_index <= 3)
							line_text="     { \"INVALID_SECURITY_DESCR\",      STATUS_INVALID_SECURITY_DESCR },"
						else if (esync_rebase_index == 4)
							line_text="     { \"INVALID_READ_MODE\",           STATUS_INVALID_READ_MODE },"
						else
							line_text="     { \"INVALID_PIPE_STATE\",          STATUS_INVALID_PIPE_STATE },"
						insert_array_entry(file_array, ++line, line_text)
						if (esync_rebase_index <= 3)
							line_text="     { \"IO_TIMEOUT\",                  STATUS_IO_TIMEOUT },"
						else if (esync_rebase_index == 4)
							line_text="     { \"INVALID_SECURITY_DESCR\",      STATUS_INVALID_SECURITY_DESCR },"
						else
							line_text="     { \"INVALID_READ_MODE\",           STATUS_INVALID_READ_MODE },"
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			diff_array["exit end line"]=line
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 2) diff_array["exit code"]=diff_array["idiff"]
}

function process_staging_patch_file_0079(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/queue.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						split("6 0 6 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ timeout_t last_get_msg; /* time of last get message call */$")) {
						line_text = (indent "unsigned int           ignore_post_msg; /* ignore post messages newer than this unique id */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file_delete_target_hunk(file_array, diff_array, target_diff_file, target_hunk,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == target_diff_file) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == target_hunk) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (is_new_hunk(file_array[line])) {
						while(!is_new_diff_file(file_array[line]))
							delete file_array[line++]
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (!diff_array["exit end line"]) diff_array["exit end line"]=line

	if (complete != 1) diff_array["exit code"]=diff_array["idiff"]
}

function process_patch_file(file_array, diff_array)
{
	printf("Pre-processing patch file: '%s' ...\n", file_name)

	if (patch_number == "0001") {
		if (esync_rebase_index >= 11)
			process_patch_file_0001(file_array, diff_array)
		if (!diff_array["exit code"] && staging && (esync_rebase_index <= 2)) {
			squash_array(file_array)
			process_staging_patch_file_0001(file_array, diff_array)
		}
	}
	else if (patch_number == "0002") {
		process_patch_file_0002(file_array, diff_array)
		if (!diff_array["exit code"] && staging) process_staging_patch_file_0002(file_array, diff_array)
	}
	else if (staging && (patch_number == "0003")) {
		process_staging_patch_file_0003(file_array, diff_array)
	}
	else if (patch_number == "0006") {
		if (!staging && (esync_rebase_index <= 2))
			process_patch_file_0006(file_array, diff_array)
		else if (staging)
			process_staging_patch_file_0006(file_array, diff_array)
	}
	else if (patch_number == "0007") {
		process_patch_file_0007(file_array, diff_array)
	}
	else if (patch_number == "0009") {
		if (esync_rebase_index >= 9)
			process_patch_file_0009(file_array, diff_array)
	}
	else if (patch_number == "0010") {
		process_patch_file_0010(file_array, diff_array)
	}
	else if (patch_number == "0011") {
		if (esync_rebase_index >= 9)
			process_patch_file_0011(file_array, diff_array)
	}
	else if (patch_number == "0013") {
		process_patch_file_0013(file_array, diff_array)
	}
	else if (patch_number == "0014") {
		process_patch_file_0014(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
# 			process_staging_patch_file_0014(file_array, diff_array)
		}
	}
	else if (patch_number == "0015") {
		process_patch_file_0015(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0015(file_array, diff_array)
		}
	}
	else if (patch_number == "0017") {
		process_patch_file_0017(file_array, diff_array)
		if (!diff_array["exit code"] && staging && (esync_rebase_index <= 11)) {
			squash_array(file_array)
			process_staging_patch_file_0017(file_array, diff_array)
		}
	}
	else if (patch_number == "0020") {
		process_patch_file_0020(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0020(file_array, diff_array)
		}
	}
	else if (staging && (patch_number == "0022")) {
		process_staging_patch_file_0022(file_array, diff_array)
	}
	else if (patch_number == "0023") {
		if ((esync_rebase_index == 0) || (esync_rebase_index >= 14))
			process_patch_file_0023(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0023(file_array, diff_array)
		}
	}
	else if (patch_number == "0024") {
		process_patch_file_0024(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0024(file_array, diff_array)
		}
		if (!diff_array["exit code"] && (esync_rebase_index <= 7)) {
			squash_array(file_array)
			process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
		}
	}
	else if (patch_number == "0025") {
		process_patch_file_0025(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0025(file_array, diff_array)
		}
	}
	else if ((patch_number == "0026") && (esync_rebase_index <= 7)) {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
	}
	else if ((patch_number == "0032") && (esync_rebase_index <= 7)) {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0033") {
		process_patch_file_0033(file_array, diff_array)
	}
	else if (patch_number == "0040") {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0041") {
		process_patch_file_0041(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0041(file_array, diff_array)
		}
		if (!diff_array["exit code"]) {
			squash_array(file_array)
			process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 3)
		}
	}
	else if (patch_number == "0042") {
		if (esync_rebase_index <= 6)
			process_patch_file_0042(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0042(file_array, diff_array)
		}
	}
	else if (patch_number == "0044") {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0045") {
		process_patch_file_0045(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0045(file_array, diff_array)
		}
	}
	else if (patch_number == "0048") {
		if ((esync_rebase_index <= 1) || (staging && (esync_rebase_index == 2)))
			process_patch_file_0048(file_array, diff_array)
	}
	else if (patch_number == "0059") {
		if (esync_rebase_index >= 20)
			process_patch_file_0059(file_array, diff_array)
	}
	else if (patch_number == "0064") {
		if ((staging && (esync_rebase_index <= 6)) || (esync_rebase_index == 7) || (esync_rebase_index >= 9))
			process_patch_file_0064(file_array, diff_array)
	}
	else if (patch_number == "0074") {
		if (esync_rebase_index <= 6) process_patch_file_0074(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0074(file_array, diff_array)
		}
	}
	else if (patch_number == "0077") {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
		squash_array(file_array)
		process_patch_file_0077(file_array, diff_array)
	}
	else if (patch_number == "0078") {
		process_patch_file_delete_target_hunk(file_array, diff_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0079") {
		process_patch_file_0079(file_array, diff_array)
		if (!diff_array["exit code"] && staging) {
			squash_array(file_array)
			process_staging_patch_file_0079(file_array, diff_array)
		}
	}

	if (diff_array["exit code"]) return diff_array["exit code"]

	squash_array(file_array)
	if (target_esync_directory) {
		print_file(file_array, (target_esync_directory "/" file_name))
	}
	else
		print_file(file_array, (file_path ".new"))
}

BEGIN{
	supported_patches="0001 0002 0006 0007 0009 0010 0011 0013 0014 0015 0017 0020 0023 0024 0025 0026 0032 0033 0040 0041 0042 0044 0045 0048 0059 0064 0074 0077 0078 0079"
	if (staging) supported_patches=(supported_patches " 0003 0022 ")
}
{
	if (FNR == 1) {
		file_path = FILENAME
		file_name = get_file_name(file_path)
		patch_number = substr(file_name,1,4)
 		if (supported_patches !~ patch_number) {
			diff_array["exit code"]=255
			exit diff_array["exit code"]
		}
	}

	file_array[++line] = $0
}
END{
	if (line) {
		file_array[0]=line
		process_patch_file(file_array, diff_array)
	}

	if (diff_array["exit code"]) {
		dump_error()
		exit diff_array["exit code"]
	}
}
