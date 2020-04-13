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
					else if ((esync_rebase_index >= 19) && (esync_rebase_index <= 32)) {
						if (file_array[line] ~ text2regexp("sys/inotify.h \\$")) {
							sub(text2regexp("sys/inotify.h"), "sys/ioctl.h", file_array[line])
							++diff_array["idiff"]
						}
					}
					else {
						if (file_array[line] ~ text2regexp("^ sys/elf32.h \\$")) {
							line_text = (indent "sys/cdio.h \\")
							file_array[line] = line_text
							++diff_array["idiff"]
						}
					}
				}
				if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 32) {
						++diff_array["idiff"]
					}
					else {
						if (file_array[line] ~ text2regexp("^ sys/exec_elf.h \\$")) {
							line_text = (indent "sys/filio.h \\")
							file_array[line] = line_text
							line_text = (indent "sys/ioctl.h \\")
							file_array[++line] = line_text
							line_text = (indent "sys/ipc.h \\")
							file_array[++line] = line_text
							++diff_array["idiff"]
						}
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
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				indent = " "
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 22) {
						diff_array["idiff"] += 3
					}
					else if (is_new_hunk(file_array[line])) {
						split("724 0 724 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("LIBS=$ac_save_LIBS$")) {
						line_text = (indent "fi")
						file_array[line-1] = line_text
						line_text = (indent "")
						file_array[line] = line_text
						line_text = (indent "    LIBS=$ac_save_LIBS")
						file_array[++line] = line_text
						++line
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ text2regexp("if test \"x$with_ldap\" != \"xno\"")) {
						line_text = (indent "    ;;")
						file_array[line] = line_text
						line_text = (indent "esac")
						file_array[++line] = line_text
						line_text = (indent "")
 						file_array[++line] = line_text
 						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
					++diff_array["idiff"]
					++complete
				}
			}
		}
		else if ((diff_array["file"] == "/configure.ac") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 18) {
						++diff_array["idiff"]
					}
					else if ((esync_rebase_index >= 19) && (esync_rebase_index <= 32)) {
						if (file_array[line] ~ text2regexp("sys/inotify.h \\$")) {
							sub(text2regexp("sys/inotify.h"), "sys/ioctl.h", file_array[line])
							++diff_array["idiff"]
						}
					}
					else {
						if (file_array[line] ~ text2regexp("^ sys/elf32.h \\$")) {
							line_text = (indent "sys/cdio.h \\")
							file_array[line] = line_text
							++diff_array["idiff"]
						}
					}
				}
				if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 32) {
						++diff_array["idiff"]
					}
					else {
						if (file_array[line] ~ text2regexp("^ sys/exec_elf.h \\$")) {
							line_text = (indent "sys/filio.h \\")
							file_array[line] = line_text
							line_text = (indent "sys/ioctl.h \\")
							file_array[++line] = line_text
							line_text = (indent "sys/ipc.h \\")
							file_array[++line] = line_text
							++diff_array["idiff"]
						}
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
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				indent = " "
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 22) {
						diff_array["idiff"] += 4
					}
					else if (is_new_hunk(file_array[line])) {
						split("-87 0 -87 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("test \"$ac_res\" = \"none required\" || AC_SUBST(RT_LIBS,\"$ac_res\")])")) {
						line_text = (indent "            [AC_DEFINE(HAVE_CLOCK_GETTIME, 1, [Define to 1 if you have the `clock_gettime' function.])")
						insert_array_entry(file_array, line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ text2regexp("LIBS=$ac_save_LIBS$")) {
						sub("^", "    ", file_array[line])
						delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 4) {
					if (file_array[line] ~ text2regexp("dnl **** Check for OpenLDAP ***")) {
						line_text = (indent "    ;;")
						file_array[line] = line_text
						line_text = (indent "esac")
						file_array[++line] = line_text
						line_text = (indent "")
 						file_array[++line] = line_text
 						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 5) {
					++diff_array["idiff"]
					++complete
				}
			}
		}
		else if ((diff_array["file"] == "/include/config.h.in") && (complete >= 6)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 1) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 31) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("/* Define if we can use ppdev.h for parallel port access */")) {
                        line_text = (indent "/* Define to 1 if you have the <port.h> header file. */")
                        file_array[line] = line_text
                        line_text = (indent "#undef HAVE_PORT_H")
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

	if (complete == 7) diff_array["exit code"] = 0
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

	if (complete == 6) diff_array["exit code"] = 0
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
						line_text = (indent "REQ_suspend_process,")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "REQ_resume_process,")
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
						line_text = (indent "struct suspend_process_request suspend_process_request;")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "struct resume_process_request resume_process_request;")
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
						line_text = (indent "struct suspend_process_reply suspend_process_reply;")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "struct resume_process_reply resume_process_reply;")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ "^ #define SERVER_PROTOCOL_VERSION [[:digit:]][[:digit:]][[:digit:]]$") {
                        if (esync_rebase_index <= 30)
                            line_text = indent
                        else
                            line_text = (indent "/* ### protocol_version begin ### */")
						file_array[line] = line_text
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
						line_text = "+    no_kernel_obj_list,        /* get_kernel_obj_list */"
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
						line_text = (indent "DECL_HANDLER(suspend_process);")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "DECL_HANDLER(resume_process);")
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
						line_text = (indent "(req_handler)req_suspend_process,")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "(req_handler)req_resume_process,")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (esync_rebase_index <= 35) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ C_ASSERT( sizeof(affinity_t) == 8 );$")) {
						line_text = (indent "C_ASSERT( sizeof(abstime_t) == 8 );")
						file_array[line] = line_text
						++diff_array["idiff"]
					}
				}
				if (diff_array["idiff"] == 4) {
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
						line_text = (indent "(dump_func)dump_suspend_process_request,")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "(dump_func)dump_resume_process_request,")
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
						line_text = (indent "\"suspend_process\",")
						insert_array_entry(file_array, ++line, line_text)
						line_text = (indent "\"resume_process\",")
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

	if (complete == 11) diff_array["exit code"] = 0
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
						line_text = ("+" substr(indent, 2) "no_alloc_handle,           /* alloc_handle */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
}

function process_patch_file_0003(file_array, diff_array,
	array_diff_lines, complete, indent, line, line_text)
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
					if (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(ntdll);$")) {
						sub("ntdll","sync",file_array[line])
						++line
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						sub(text2regexp("NTSTATUS WINAPI NtSetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"),
							"NTSTATUS WINAPI NtOpenEvent( HANDLE *handle, ACCESS_MASK access, const OBJECT_ATT",
							file_array[line])
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
							line_text = (indent "{")
							insert_array_entry(file_array, ++line, line_text)
							indent=(indent "    ")
							line_text = (indent "req->handle = wine_server_obj_handle( handle );")
							insert_array_entry(file_array, ++line, line_text)
							++diff_array["idiff"]
							++complete
						}
					}
				}
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
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
							sub(text2regexp("NTSTATUS WINAPI NtResetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"),
								"NTSTATUS WINAPI NtSetEvent( HANDLE handle, LONG *prev_state )",
								file_array[line])
						else
							sub(text2regexp("NTSTATUS WINAPI NtResetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"),
								"NTSTATUS WINAPI NtResetEvent( HANDLE handle, LONG *prev_state )",
								file_array[line])
						split("+55 0 +55 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						if ((esync_rebase_index >= 10) || ((esync_rebase_index == 9) && staging)) {
							line_text = " NTSTATUS WINAPI NtResetEvent( HANDLE handle, LONG *prev_state )"
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
							line_text = "if (prev_state) *prev_state = 0;"
							file_array[line] = (indent line_text)
							file_array[++line] = " "
						}
						else {
							line_text = "{"
							file_array[line] = (indent line_text)
							line_text =  "req->handle = wine_server_obj_handle( handle );"
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

	if (complete == 1) diff_array["exit code"] = 0
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
						line_text = (indent "SERVER_START_REQ( event_op )")
						file_array[line] = line_text
						line_text = (indent "{")
						file_array[++line] = line_text
						indent=(indent "    ")
						line_text = (indent "req->handle = wine_server_obj_handle( handle );")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
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
					else if (sub(text2regexp("named_pipe_device_get_fd, /* get_fd */"), "no_get_fd,                        /* get_fd */", file_array[line])) {
						++diff_array["idiff"]
						++complete
					}
					diff_array["exit end line"]=line
				}
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
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
						line_text = (indent "REQ_suspend_process,")
						file_array[line] = line_text
						line_text = (indent "REQ_resume_process,")
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
						line_text = (indent "struct suspend_process_request suspend_process_request;")
						file_array[line] = line_text
						line_text = (indent "struct resume_process_request resume_process_request;")
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
						line_text = (indent "struct suspend_process_reply suspend_process_reply;")
						file_array[line] = line_text
						line_text = (indent "struct resume_process_reply resume_process_reply;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (file_array[line] ~ "^[- ]#define SERVER_PROTOCOL_VERSION [[:digit:]][[:digit:]][[:digit:]]$") {
						# patch: 0014-server-Add-a-request-to-get-the-eventfd-file-descrip.patch
						# for esync release tarball: esyncb4478b7.tgz
						# has invalid line counts... Fix this!
						indent=" "
						if (esync_rebase_index <= 30)
							line_text = indent
						else
							line_text = (indent "/* ### protocol_version begin ### */")
						file_array[line] = line_text
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
						line_text = (indent "DECL_HANDLER(suspend_process);")
						file_array[line] = line_text
						line_text = (indent "DECL_HANDLER(resume_process);")
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
						line_text = (indent "(req_handler)req_suspend_process,")
						file_array[line] = line_text
						line_text = (indent "(req_handler)req_resume_process,")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (esync_rebase_index <= 35) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ C_ASSERT( sizeof(affinity_t) == 8 );$")) {
						line_text = (indent "C_ASSERT( sizeof(abstime_t) == 8 );")
						file_array[line] = line_text
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
						line_text = (indent "(dump_func)dump_suspend_process_request,")
						file_array[line] = line_text
						line_text = (indent "(dump_func)dump_resume_process_request,")
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
						line_text = (indent "\"suspend_process\",")
						file_array[line] = line_text
						line_text = (indent "\"resume_process\",")
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

	if (complete == 9) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
			else if ((diff_array["ihunk"] == 4) && (complete >= 1)) {
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
			else if ((diff_array["ihunk"] == 5) && (complete >= 2)) {
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
		else if (diff_array["file"] == "/server/process.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
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

	if (complete == 4) diff_array["exit code"] = 0
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

	if (complete == 2) diff_array["exit code"] = 0
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

	if (complete == 4) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						if (sub(text2regexp("static void destroy_thread( struct object *obj );$"),
							"static struct list *thread_get_kernel_obj_list( struct object *obj );",
								file_array[line]))
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
			else if (diff_array["ihunk"] == 3) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 28) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ thread->suspend = 0;$")) {
						indent = "     "
						line_text = (indent "thread->token           = NULL;")
						file_array[line] = line_text
						line_text = (indent "thread->desc            = NULL;")
						file_array[++line] = line_text
						line_text = (indent "thread->desc_len        = 0;")
						file_array[++line] = line_text
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 15) {
						diff_array["idiff"]+=2
					}
					else if (file_array[line] ~ text2regexp("^ timeout_t creation_time; /* Thread creation time */$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if ((esync_rebase_index <= 28) && (file_array[line] ~ text2regexp("^ struct token *token; /* security token associated with this thread */$"))) {
						line_text = (indent "struct list            kernel_object; /* list of kernel object pointers */")
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
					}
					else if ((esync_rebase_index >= 29) && (file_array[line] ~ text2regexp("^ timeout_t exit_time; /* Thread exit time */$"))) {
						indent="     "
						line_text = "struct list            kernel_object; /* list of kernel object pointers */"
						file_array[line] = (indent line_text)
						line_text = "data_size_t            desc_len;      /* thread description length in bytes */"
						file_array[++line] = (indent line_text)
						line_text = "WCHAR                 *desc;          /* thread description string */"
						insert_array_entry(file_array, ++line, (indent line_text))
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					++diff_array["idiff"]
					++complete
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 3) diff_array["exit code"] = 0
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
					if ((esync_rebase_index <= 8) && sub(text2regexp("return (mythread->state == TERMINATED);$"),
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

	if (complete == 4) diff_array["exit code"] = 0
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

	if (complete == 3) diff_array["exit code"] = 0
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
						if (staging)	line_text = " @ cdecl __wine_user_shared_data()"
						else			line_text = " @ cdecl __wine_init_windows_dir(wstr wstr)"
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
						line_text = (indent "thread_data->reply_fd   = -1;")
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

	if (complete == 2) diff_array["exit code"] = 0
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

			if ((diff_array["ihunk"] == 2) && (complete >= 2)) {
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

	if (complete == 3) diff_array["exit code"] = 0
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

	if (complete == 6) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
}

function process_patch_file_0025(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"] = diff_array["exit end line"] = 0
	
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/device.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 11) {
						diff_array["idiff"] += 4
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
						if (esync_rebase_index >= 21) {
							delete file_array[++line]
							++diff_array["idiff"]
						}
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
						if (esync_rebase_index >= 21) {
							line_text = (indent "struct irp_call       *current_call;   /* call currently executed on client side */")
							insert_array_entry(file_array, ++line, line_text)
						}
						line_text = (indent "struct wine_rb_tree    kernel_objects; /* map of objects that have client side pointer associated */")
						insert_array_entry(file_array, ++line, line_text)
						if (sub(text2regexp("int esync_fd;"), "& ", file_array[++line])) ++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 5) {
					++diff_array["idiff"]
					++complete
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
						line_text = (indent "    while ((ptr = list_head( &manager->requests )))")
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
				if (esync_rebase_index >= 22) indent=(indent "    ")
				if (diff_array["idiff"] == 1) {
					if ((esync_rebase_index <= 11) || (!staging && (esync_rebase_index == 12))) {
						diff_array["idiff"] += 4
					}
					else if (is_new_hunk(file_array[line])) {
						if (esync_rebase_index == 22)
							split("176 0 176 0", array_diff_lines)
						else if (esync_rebase_index == 21)
							split("155 0 155 0", array_diff_lines)
						else
							split("8 0 8 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						delete file_array[++line]
						if (esync_rebase_index >= 21) delete file_array[++line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("list_init( &irp->mgr_entry );$")) {
						if (esync_rebase_index >= 22) {
							line_text = (indent "/* we already own the object if it's only on manager queue */")
							file_array[line] = line_text
							line_text = (indent "if (irp->file) grab_object( irp );")
							insert_array_entry(file_array, ++line, line_text)
						}
						else if (esync_rebase_index == 21) {
							line_text = (indent "if (irp->file) grab_object( irp ); /* we already own the object if it's only on manager queue */")
							insert_array_entry(file_array, ++line, line_text)
						}
						else {
							line_text = (indent "if (!irp->file) release_object( irp ); /* no longer on manager queue */")
							insert_array_entry(file_array, ++line, line_text)
						}
						if (esync_rebase_index >= 21) {
							line_text = (indent "manager->current_call = irp;")
							insert_array_entry(file_array, ++line, line_text)
						}
						if (esync_rebase_index >= 22) {
							sub("^[+]", "&    ", file_array[line+2])
							sub("^[+]", "&    ", file_array[line+3])
						}
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 3) {
					if (esync_rebase_index <= 21) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("}$")) {
						sub("^", "    ", file_array[line])
						line_text = (indent "else close_handle( current->process, reply->next );")
						insert_array_entry(file_array, ++line, line_text)
						sub("^", "    ", file_array[++line])
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 4) {
					if (esync_rebase_index <= 21) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("else set_error( STATUS_PENDING );$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 5) {
						++diff_array["idiff"]
						++complete
				}
			}
		}
	}

	if (complete == 4) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						line_text = (indent "REQ_suspend_process,")
						file_array[line] = line_text
						line_text = (indent "REQ_resume_process,")
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
						line_text = (indent "struct suspend_process_request suspend_process_request;")
						file_array[line] = line_text
						line_text = (indent "struct resume_process_request resume_process_request;")
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
						line_text = (indent "struct suspend_process_reply suspend_process_reply;")
						file_array[line] = line_text
						line_text = (indent "struct resume_process_reply resume_process_reply;")
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
						line_text = (indent "DECL_HANDLER(suspend_process);")
						file_array[line] = line_text
						line_text = (indent "DECL_HANDLER(resume_process);")
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
						line_text = (indent "(req_handler)req_suspend_process,")
						file_array[line] = line_text
						line_text = (indent "(req_handler)req_resume_process,")
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
						line_text = (indent "(dump_func)dump_suspend_process_request,")
						file_array[line] = line_text
						line_text = (indent "(dump_func)dump_resume_process_request,")
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
						line_text = (indent "\"suspend_process\",")
						file_array[line] = line_text
						line_text = (indent "\"resume_process\",")
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

	if (complete == 7) diff_array["exit code"] = 0
}

function process_patch_file_0040(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (diff_array["file"] == "/server/timer.c") {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 5) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 34) {
						++diff_array["idiff"]
					}
					else {
						if (file_array[line] ~ text2regexp("timer->when = (expire <= 0) ? current_time - expire : max( expire, current_time );")) {
							line_text=(indent "timer->when     = (expire <= 0) ? expire - monotonic_time : max( expire, current_time );")
							file_array[line] = line_text
							++diff_array["idiff"]
						}
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

	if (complete == 1) diff_array["exit code"] = 0
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
		else if (diff_array["file"] == "/server/esync.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 2) && (complete >= 2)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 29) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^+ if (stat( wine_get_config_dir(), &st ) == -1)")) {
						line_text = "+    if (fstat( config_dir_fd, &st ) == -1)"
						file_array[line] = line_text
						line_text = "+        fatal_error( \"cannot stat config dir\\n\" );"
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
		else if (diff_array["file"] == "/server/main.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 3)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 29) {
						diff_array["idiff"] += 2
					}
					else if (file_array[line] ~ text2regexp("^ #include \"wine/library.h\"$")) {
						delete file_array[line]
						++diff_array["idiff"]
					}
				}
				else if (diff_array["idiff"] == 2) {
					if (file_array[line] ~ text2regexp("^ /* command-line options */$")) {
						line_text = (indent "int debug_level = 0;")
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
			else if ((diff_array["ihunk"] == 2) && (complete >= 4)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 33) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ init_signals();$")) {
						line_text = (indent "set_current_time();")
						file_array[line] = line_text
						line_text = (indent "init_signals();")
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

	if (complete == 5) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						line_text = (" " "WINE_DECLARE_DEBUG_CHANNEL(relay);")
						file_array[++line] = line_text
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
			else if ((diff_array["ihunk"] == 2) && (complete >= 1)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$")) {
						line_text = " "
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

	if (complete == 2) diff_array["exit code"] = 0
}

function regenerate_patch_file_0042(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (file_array[line] ~ text2regexp("^From ")) {
			sub("56864692e4ed8f588a5dcee931e70fe6da0a1920",
				"74673086285abb335d58cecf4327bf08034210a6",
				file_array[line])
			++complete
		}
		else if (file_array[line] ~ text2regexp("^Subject: ")) {
			line_text = "Subject: [PATCH] ntdll: Use shared memory segments to store semaphore and"
			file_array[line] = line_text
			line_text = " mutex state."
			file_array[++line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ dlls/ntdll/thread.c | 4 +")) {
			line_text = " dlls/ntdll/loader.c |   4 +"
			file_array[line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^diff --git a/dlls/ntdll/thread.c b/dlls/ntdll/thread.c")) {
			line_text = "diff --git a/dlls/ntdll/loader.c b/dlls/ntdll/loader.c"
			file_array[line] = line_text
			line_text = "index 9972d680e..f9c529357 100644"
			file_array[++line] = line_text
			line_text = "--- a/dlls/ntdll/loader.c"
			file_array[++line] = line_text
			line_text = "+++ b/dlls/ntdll/loader.c"
			file_array[++line] = line_text
			line_text = "@@ -44,6 +44,7 @@"
			file_array[++line] = line_text
			line_text = " #include \"wine/server.h\""
			insert_array_entry(file_array, ++line, line_text)
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ #include \"wine/exception.h\"")) {
			delete file_array[line]
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(thread);")) {
			line_text = " WINE_DEFAULT_DEBUG_CHANNEL(module);"
			file_array[line] = line_text
			line_text = " WINE_DECLARE_DEBUG_CHANNEL(relay);"
			file_array[++line] = line_text
			line_text = "@@ -4246,6 +4247,9 @@ void __wine_process_init(void)"
			file_array[++line] = line_text
			line_text = "     peb->ProcessHeap = RtlCreateHeap( HEAP_GROWABLE, NULL, 0, 0, NULL, NULL );"
			file_array[++line] = line_text
			line_text = "     peb->LoaderLock = &loader_section;"
			file_array[++line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$")) {
			if (esync_rebase_index <= 27) {
				line_text = "     init_directories();"
				file_array[line] = line_text
				line_text = "     init_user_process_params( info_size );"
				file_array[++line] = line_text
			}
			else {
				line_text = "     init_unix_codepage();"
				file_array[line] = line_text
				line_text = "     init_directories();"
				file_array[++line] = line_text
				line_text = "     init_user_process_params( info_size );"
				file_array[++line] = line_text
			}
			++complete
		}
		else if (file_array[line] ~ text2regexp("2.19.1")) {
			line_text = "2.23.0"
			file_array[line] = line_text
			++complete
		}
	}

	if (complete == 8) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						line_text = (indent "thread_data->wait_fd[0] = -1;")
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
						indent=" "
						if (esync_rebase_index <= 30)
							line_text = indent
						else
							line_text = (indent "/* ### protocol_version begin ### */")
						file_array[line] = line_text
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
		else if ((diff_array["file"] == "/server/request.h") && (complete >= 3)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 35) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ C_ASSERT( sizeof(affinity_t) == 8 );$")) {
						line_text = (indent "C_ASSERT( sizeof(abstime_t) == 8 );")
						file_array[line] = line_text
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
		else if (diff_array["file"] == "/server/thread.c") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 4)) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 28) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ thread->desktop_users = 0;$")) {
						indent = "     "
						line_text = (indent "thread->desc            = NULL;")
						file_array[line] = line_text
						line_text = (indent "thread->desc_len        = 0;")
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
		else if (diff_array["file"] == "/server/thread.h") {
			preprocess_diff_file(line, diff_array)

			if ((diff_array["ihunk"] == 1) && (complete >= 5)) {
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
							if (esync_rebase_index <= 28) {
								line_text = (indent "struct list            kernel_object; /* list of kernel object pointers */")
								insert_array_entry(file_array, ++line, line_text)
							}
							else {
								line_text = (indent "data_size_t            desc_len;      /* thread description length in bytes */")
								file_array[line] = line_text
								line_text = (indent "WCHAR                 *desc;          /* thread description string */")
								insert_array_entry(file_array, ++line, line_text)
							}
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

			if ((diff_array["ihunk"] == 1) && (complete >= 6)) {
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

	if (complete == 7) diff_array["exit code"] = 0
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
						line_text = "thread->exit_poll       = NULL;"
						file_array[++line] = (indent line_text)
						line_text = "thread->shm_fd          = -1;"
						file_array[++line] = (indent line_text)
						line_text = "thread->shm             = NULL;"
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
						line_text = "struct timeout_user   *exit_poll;     /* poll if the thread/process has exited already */"
						file_array[++line] = (indent line_text)
						line_text = "int                    shm_fd;        /* file descriptor for thread local shared memory */"
						file_array[++line] = (indent line_text)
						line_text = "shmlocal_t            *shm;           /* thread local shared memory pointer */"
						file_array[++line] = (indent line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 4) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
}

function process_patch_file_0051(file_array, diff_array,
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
					if (file_array[line] ~ text2regexp("static NTSTATUS (WINAPI *pNtAllocateVirtualMemory)(HANDLE, PVOID *, ULONG, SIZE_T *, ULONG, ULONG);")) {
						sub(text2regexp("(HANDLE, PVOID *, ULONG, SIZE_T *, ULONG, ULONG)"),"(HANDLE, PVOID *, ULONG_PTR, SIZE_T *, ULONG, ULONG)", file_array[line])
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 2) diff_array["exit code"] = 0
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

	if (complete == 4) diff_array["exit code"] = 0
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
						else if (esync_rebase_index <= 5)
							insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
				diff_array["exit end line"]=line
			}
		}
	}

	if (complete == 1) diff_array["exit code"] = 0
}

function regenerate_patch_file_0074(file_array, diff_array,
	complete, indent, line, line_text)
{
	diff_array["exit start line"]=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		preprocess_patch_file_line(file_array[line], diff_array)

		if (file_array[line] ~ text2regexp("^From ")) {
			sub("7b617b003abd29e7869178cb8ca108802691159f",
				"4293d1e7797b999611ecc410b24052a1566715b6",
				file_array[line])
			++complete
		}
		else if (file_array[line] ~ text2regexp("^Subject: ")) {
			line_text = "Subject: [PATCH] ntdll, server: Abort if esync is enabled for the server but"
			file_array[line] = line_text
			line_text = " not the client, and vice versa."
			file_array[++line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ dlls/ntdll/thread.c |  3 +--$")) {
			line_text = " dlls/ntdll/loader.c |  3 +--"
			file_array[line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^index 3ab069da9..1dd96c8e6 100644$")) {
			line_text = "index 8255810a9..fb1953fb9 100644"
			file_array[line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^diff --git a/dlls/ntdll/thread.c b/dlls/ntdll/thread.c")) {
			line_text = "diff --git a/dlls/ntdll/loader.c b/dlls/ntdll/loader.c"
			file_array[line] = line_text
			line_text = "index f9c529357..80f1304a3 100644"
			file_array[++line] = line_text
			line_text = "--- a/dlls/ntdll/loader.c"
			file_array[++line] = line_text
			line_text = "+++ b/dlls/ntdll/loader.c"
			file_array[++line] = line_text
			line_text = "@@ -4405,8 +4405,7 @@ void __wine_process_init(void)"
			file_array[++line] = line_text
			line_text = "     peb->ProcessHeap = RtlCreateHeap( HEAP_GROWABLE, NULL, 0, 0, NULL, NULL );"
			file_array[++line] = line_text
			line_text = "     peb->LoaderLock = &loader_section;"
			file_array[++line] = line_text
			++complete
		}
		else if (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$")) {
			if (esync_rebase_index <= 27) {
				line_text = "     init_directories();"
				file_array[line] = line_text
				line_text = "     init_user_process_params( info_size );"
				file_array[++line] = line_text
			}
			else {
				line_text = "     init_unix_codepage();"
				file_array[line] = line_text
				line_text = "     init_directories();"
				file_array[++line] = line_text
				line_text = "     init_user_process_params( info_size );"
				file_array[++line] = line_text
			}
			++complete
		}
		else if (file_array[line] ~ text2regexp("2.19.1")) {
			line_text = "2.23.0"
			file_array[line] = line_text
			++complete
		}
	}

	if (complete == 7) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
						indent=" "
						if (esync_rebase_index <= 30)
							line_text = indent
						else
							line_text = (indent "/* ### protocol_version begin ### */")
						file_array[line] = line_text
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
		else if ((diff_array["file"] == "/server/request.h") && (complete >= 1)) {
			preprocess_diff_file(line, diff_array)

			if (diff_array["ihunk"] == 2) {
				preprocess_diff_file_hunk(line, file_array, diff_array)
				if (diff_array["idiff"] == 1) {
					if (esync_rebase_index <= 35) {
						++diff_array["idiff"]
					}
					else if (file_array[line] ~ text2regexp("^ C_ASSERT( sizeof(affinity_t) == 8 );$")) {
						line_text = (indent "C_ASSERT( sizeof(abstime_t) == 8 );")
						file_array[line] = line_text
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
		else if ((diff_array["file"] == "/server/trace.c") && (complete >= 2)) {
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
						line_text = "@@ -5460,4 +5554,5 @@ static const struct"
						insert_array_entry(file_array, line, line_text)
						line_text = "     { \"INVALID_OWNER\",               STATUS_INVALID_OWNER },"
						insert_array_entry(file_array, ++line, line_text)
						line_text = "     { \"INVALID_PARAMETER\",           STATUS_INVALID_PARAMETER },"
						insert_array_entry(file_array, ++line, line_text)
						line_text = "+    { \"INVALID_PARAMETER_4\",         STATUS_INVALID_PARAMETER_4 },"
						insert_array_entry(file_array, ++line, line_text)
						if (esync_rebase_index <= 3)
							line_text = "     { \"INVALID_SECURITY_DESCR\",      STATUS_INVALID_SECURITY_DESCR },"
						else if (esync_rebase_index == 4)
							line_text = "     { \"INVALID_READ_MODE\",           STATUS_INVALID_READ_MODE },"
						else
							line_text = "     { \"INVALID_PIPE_STATE\",          STATUS_INVALID_PIPE_STATE },"
						insert_array_entry(file_array, ++line, line_text)
						if (esync_rebase_index <= 3)
							line_text = "     { \"IO_TIMEOUT\",                  STATUS_IO_TIMEOUT },"
						else if (esync_rebase_index == 4)
							line_text = "     { \"INVALID_SECURITY_DESCR\",      STATUS_INVALID_SECURITY_DESCR },"
						else
							line_text = "     { \"INVALID_READ_MODE\",           STATUS_INVALID_READ_MODE },"
						insert_array_entry(file_array, ++line, line_text)
						++diff_array["idiff"]
						++complete
					}
				}
			}
			diff_array["exit end line"]=line
		}
	}

	if (complete == 3) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
}

function generate_patch_file_0084(file_array, diff_array,
	complete, line, line_text)
{
	diff_array["exit start line"]=0
	diff_array["idiff"]=0

	line_text = "From 770e803adbc13c78ee52c7e8435d651da854fcf1 Mon Sep 17 00:00:00 2001"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "From: Zebediah Figura <z.figura12@gmail.com>"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Date: Wed, 24 Apr 2019 23:21:25 -0500"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Subject: [PATCH] server: Create esync file descriptors for true file objects"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " and use them for directory change notifications."
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "---"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " server/change.c | 2 +-"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " server/fd.c     | 3 +++"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " 2 files changed, 4 insertions(+), 1 deletion(-)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/server/change.c b/server/change.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index 2be6a8360..9f07be705 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/server/change.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/server/change.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -115,7 +115,7 @@ static const struct object_ops dir_ops ="
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     add_queue,                /* add_queue */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     remove_queue,             /* remove_queue */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     default_fd_signaled,      /* signaled */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    NULL,                     /* get_esync_fd */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    default_fd_get_esync_fd,  /* get_esync_fd */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     no_satisfied,             /* satisfied */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     no_signal,                /* signal */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     dir_get_fd,               /* get_fd */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/server/fd.c b/server/fd.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index 95f289718..9f51d065e 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/server/fd.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/server/fd.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -1625,6 +1625,9 @@ static struct fd *alloc_fd_object(void)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     list_init( &fd->inode_entry );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     list_init( &fd->locks );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (do_esync())"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        fd->esync_fd = esync_create_fd( 1, 0 );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if ((fd->poll_index = add_poll_user( fd )) == -1)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         release_object( fd );"
	insert_array_entry(file_array, ++line, line_text)

	complete = ++diff_array["idiff"]

	if (complete == 1) diff_array["exit code"] = 0
}

function generate_patch_file_0085(file_array, diff_array,
	complete, line, line_text)
{
	diff_array["exit start line"]=0
	diff_array["idiff"]=0

	line_text = "From 9e4df70f7282b04849153b3fa2edf15dc24eaf4f Mon Sep 17 00:00:00 2001"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "From: Zebediah Figura <zfigura@codeweavers.com>"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Date: Tue, 23 Jul 2019 18:39:06 -0500"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Subject: [PATCH] server: Only signal the APC fd for user APCs."
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Otherwise we might incorrectly return WAIT_IO_COMPLETION to the user when a system APC runs."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "---"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " server/thread.c | 2 +-"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " 1 file changed, 1 insertion(+), 1 deletion(-)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/server/thread.c b/server/thread.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index fc751c2cb..2e77e5ff2 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/server/thread.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/server/thread.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -1057,7 +1057,7 @@ static int queue_apc( struct process *process, struct thread *thread, struct thr"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         wake_thread( thread );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        if (do_esync())"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        if (do_esync() && queue == &thread->user_apc)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             esync_wake_fd( thread->esync_apc_fd );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-- "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "2.23.0"
	insert_array_entry(file_array, ++line, line_text)

	complete = ++diff_array["idiff"]

	if (complete == 1) diff_array["exit code"] = 0
}

function generate_patch_file_0086(file_array, diff_array,
	complete, line, line_text)
{
	diff_array["exit start line"]=0
	diff_array["idiff"]=0

	line_text = "From 836f1b6b0560bd178efb8d52900b4b136f87ae30 Mon Sep 17 00:00:00 2001"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "From: Zebediah Figura <zfigura@codeweavers.com>"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Date: Tue, 23 Jul 2019 17:22:20 -0500"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Subject: [PATCH] ntdll: Check the APC fd first."
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "---"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " dlls/ntdll/esync.c | 13 ++++++++-----"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " 1 file changed, 8 insertions(+), 5 deletions(-)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/dlls/ntdll/esync.c b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index fc621ccfb..0adb4ad77 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -1046,6 +1046,14 @@ static NTSTATUS __esync_wait_objects( DWORD count, const HANDLE *handles,"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             ret = do_poll( fds, pollcount, timeout ? &end : NULL );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             if (ret > 0)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                /* We must check this first! The server may set an event that"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                 * we're waiting on, but we need to return STATUS_USER_APC. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                if (alertable)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                    if (fds[pollcount - 1].revents & POLLIN)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                        goto userapc;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                 /* Find out which object triggered the wait. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                 for (i = 0; i < count; i++)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                 {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -1089,11 +1097,6 @@ static NTSTATUS __esync_wait_objects( DWORD count, const HANDLE *handles,"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                         return count - 1;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                 }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-                if (alertable)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-                {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-                    if (fds[i++].revents & POLLIN)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-                        goto userapc;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-                }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                 /* If we got here, someone else stole (or reset, etc.) whatever"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                  * we were waiting for. So keep waiting. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-- "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "2.23.0"
	insert_array_entry(file_array, ++line, line_text)

	complete = ++diff_array["idiff"]

	if (complete == 1) diff_array["exit code"] = 0
}

function generate_patch_file_0087(file_array, diff_array,
	complete, line, line_text)
{
	diff_array["exit start line"]=0
	diff_array["idiff"]=0

	line_text = "From c1804983dc8e9509c088c35914212cda1bd5a48a Mon Sep 17 00:00:00 2001"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "From: Zebediah Figura <zfigura@codeweavers.com>"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Date: Wed, 7 Aug 2019 17:14:54 -0500"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Subject: [PATCH] ntdll/esync: Lock accessing the shm_addrs array."
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "---"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " dlls/ntdll/esync.c | 18 +++++++++++++++++-"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " 1 file changed, 17 insertions(+), 1 deletion(-)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/dlls/ntdll/esync.c b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index 0adb4ad77..2f030c141 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -155,10 +155,22 @@ void esync_init(void)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     shm_addrs_size = 128;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+static RTL_CRITICAL_SECTION shm_addrs_section;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+static RTL_CRITICAL_SECTION_DEBUG shm_addrs_debug ="
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+{"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    0, 0, &shm_addrs_section,"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    { &shm_addrs_debug.ProcessLocksList, &shm_addrs_debug.ProcessLocksList },"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+      0, 0, { (DWORD_PTR)(__FILE__ \": shm_addrs_section\") }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+};"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+static RTL_CRITICAL_SECTION shm_addrs_section = { &shm_addrs_debug, -1, 0, 0, 0, 0 };"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " static void *get_shm( unsigned int idx )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     int entry  = (idx * 8) / pagesize;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     int offset = (idx * 8) % pagesize;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    void *ret;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    RtlEnterCriticalSection(&shm_addrs_section);"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (entry >= shm_addrs_size)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -180,7 +192,11 @@ static void *get_shm( unsigned int idx )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             munmap( addr, pagesize ); /* someone beat us to it */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    return (void *)((unsigned long)shm_addrs[entry] + offset);"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    ret = (void *)((unsigned long)shm_addrs[entry] + offset);"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    RtlLeaveCriticalSection(&shm_addrs_section);"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    return ret;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = " /* We'd like lookup to be fast. To that end, we use a static list indexed by handle."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-- "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "2.23.0"
	insert_array_entry(file_array, ++line, line_text)

	complete = ++diff_array["idiff"]

	if (complete == 1) diff_array["exit code"] = 0
}

function generate_patch_file_0088(file_array, diff_array,
	complete, line, line_text)
{
	diff_array["exit start line"]=0
	diff_array["idiff"]=0

	line_text = "From c41dc5b8c422be3914cd31c239ec586a091b8a3b Mon Sep 17 00:00:00 2001"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "From: Zebediah Figura <zfigura@codeweavers.com>"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Date: Mon, 10 Jun 2019 11:25:34 -0400"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "Subject: [PATCH] ntdll: Get rid of the per-event spinlock for auto-reset"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " events."
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "It's not necessary. Much like semaphores, the shm state is just a hint."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "---"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " dlls/ntdll/esync.c | 74 +++++++++++++++++++++++++++++++++++-----------"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " server/esync.c     | 32 +++++++++++++-------"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " 2 files changed, 78 insertions(+), 28 deletions(-)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = ""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/dlls/ntdll/esync.c b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index 2f030c141..87f303403 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/dlls/ntdll/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -570,6 +570,14 @@ static inline void small_pause(void)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "  * problem at all."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "  */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+/* Removing this spinlock is harder than it looks. esync_wait_objects() can"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * deal with inconsistent state well enough, and a race between SetEvent() and"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * ResetEvent() gives us license to yield either result as long as we act"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * consistently, but that's not enough. Notably, esync_wait_objects() should"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * probably act like a fence, so that the second half of esync_set_event() does"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * not seep past a subsequent reset. That's one problem, but no guarantee there"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+ * aren't others. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " NTSTATUS esync_set_event( HANDLE handle, LONG *prev )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     static const uint64_t value = 1;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -583,21 +591,36 @@ NTSTATUS esync_set_event( HANDLE handle, LONG *prev )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if ((ret = get_object( handle, &obj ))) return ret;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     event = obj->shm;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (obj->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    /* For manual-reset events, as long as we're in a lock, we can take the"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * optimization of only calling write() if the event wasn't already"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * signaled."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     *"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * For auto-reset events, esync_wait_objects() must grab the kernel object."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * Thus if we got into a race so that the shm state is signaled but the"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * eventfd is unsignaled (i.e. reset shm, set shm, set fd, reset fd), we"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * *must* signal the fd now, or any waiting threads will never wake up. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     /* Only bother signaling the fd if we weren't already signaled. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    if (!(current = interlocked_xchg( &event->signaled, 1 )))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (!(current = interlocked_xchg( &event->signaled, 1 )) || obj->type == ESYNC_AUTO_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         if (write( obj->fd, &value, sizeof(value) ) == -1)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-            return FILE_GetNtStatus();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            ERR(\"write: %s\n\", strerror(errno));"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (prev) *prev = current;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (obj->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     return STATUS_SUCCESS;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -615,21 +638,34 @@ NTSTATUS esync_reset_event( HANDLE handle, LONG *prev )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if ((ret = get_object( handle, &obj ))) return ret;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     event = obj->shm;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (obj->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Only bother signaling the fd if we weren't already signaled. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    if ((current = interlocked_xchg( &event->signaled, 0 )))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    /* For manual-reset events, as long as we're in a lock, we can take the"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * optimization of only calling read() if the event was already signaled."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     *"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * For auto-reset events, we have no guarantee that the previous \"signaled\""
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * state is actually correct. We need to leave both states unsignaled after"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+     * leaving this function, so we always have to read(). */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if ((current = interlocked_xchg( &event->signaled, 0 )) || obj->type == ESYNC_AUTO_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        /* we don't care about the return value */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        read( obj->fd, &value, sizeof(value) );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        if (read( obj->fd, &value, sizeof(value) ) == -1 && errno != EWOULDBLOCK && errno != EAGAIN)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            ERR(\"read: %s\n\", strerror(errno));"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (prev) *prev = current;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (obj->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     return STATUS_SUCCESS;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -844,8 +880,9 @@ static void update_grabbed_object( struct esync *obj )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     else if (obj->type == ESYNC_AUTO_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         struct event *event = obj->shm;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        /* We don't have to worry about a race between this and read(), for"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-         * reasons described near esync_set_event(). */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* We don't have to worry about a race between this and read(), since"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+         * this is just a hint, and the real state is in the kernel object."
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+         * This might already be 0, but that's okay! */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         event->signaled = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -1094,6 +1131,7 @@ static NTSTATUS __esync_wait_objects( DWORD count, const HANDLE *handles,"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                         }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                         else"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                         {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+                            /* FIXME: Could we check the poll or shm state first? Should we? */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                             if ((size = read( fds[i].fd, &value, sizeof(value) )) == sizeof(value))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                             {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "                                 /* We found our object. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "diff --git a/server/esync.c b/server/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "index 4521993d4..84d0951cb 100644"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "--- a/server/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+++ b/server/esync.c"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -396,9 +396,12 @@ void esync_set_event( struct esync *esync )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (debug_level)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         fprintf( stderr, \"esync_set_event() fd=%d\n\", esync->fd );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (esync->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (!interlocked_xchg( &event->signaled, 1 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -406,8 +409,11 @@ void esync_set_event( struct esync *esync )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "             perror( \"esync: write\" );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (esync->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = " void esync_reset_event( struct esync *esync )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -421,9 +427,12 @@ void esync_reset_event( struct esync *esync )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (debug_level)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         fprintf( stderr, \"esync_reset_event() fd=%d\n\", esync->fd );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-        small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (esync->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Acquire the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        while (interlocked_cmpxchg( &event->locked, 1, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+            small_pause();"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     /* Only bother signaling the fd if we weren't already signaled. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     if (interlocked_xchg( &event->signaled, 0 ))"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "@@ -432,8 +441,11 @@ void esync_reset_event( struct esync *esync )"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "         read( esync->fd, &value, sizeof(value) );"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "     }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-    event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    if (esync->type == ESYNC_MANUAL_EVENT)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    {"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        /* Release the spinlock. */"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+        event->locked = 0;"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "+    }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " }"
	insert_array_entry(file_array, ++line, line_text)
	line_text = " "
	insert_array_entry(file_array, ++line, line_text)
	line_text = " DECL_HANDLER(create_esync)"
	insert_array_entry(file_array, ++line, line_text)
	line_text = "-- "
	insert_array_entry(file_array, ++line, line_text)
	line_text = "2.23.0"
	insert_array_entry(file_array, ++line, line_text)

	complete = ++diff_array["idiff"]

	if (complete == 1) diff_array["exit code"] = 0
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

	if (complete == 1) diff_array["exit code"] = 0
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
	else if (patch_number == "0003") {
		if (esync_rebase_index >= 24)
			process_patch_file_0003(file_array, diff_array)
		if (staging) process_staging_patch_file_0003(file_array, diff_array)
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
		process_patch_file_0040(file_array, diff_array)
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
		if (esync_rebase_index >= 27)
			regenerate_patch_file_0042(file_array, diff_array)
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
	else if (patch_number == "0051") {
		if (esync_rebase_index >= 25)
			process_patch_file_0051(file_array, diff_array)
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
		if (esync_rebase_index <= 6)
			process_patch_file_0074(file_array, diff_array)
		if (esync_rebase_index >= 27)
			regenerate_patch_file_0074(file_array, diff_array)
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
	else if (patch_number == "0084") {
		generate_patch_file_0084(file_array, diff_array)
	}
	else if (patch_number == "0085") {
		generate_patch_file_0085(file_array, diff_array)
	}
	else if (patch_number == "0086") {
		generate_patch_file_0086(file_array, diff_array)
	}
	else if (patch_number == "0087") {
		generate_patch_file_0087(file_array, diff_array)
	}
	else if (patch_number == "0088") {
		generate_patch_file_0088(file_array, diff_array)
	}

	if (diff_array["exit code"]) return diff_array["exit code"]

	squash_array(file_array)
	if (target_esync_directory) {
		print_file(file_array, (target_esync_directory "/" file_name))
	}
	else {
		print_file(file_array, (file_path ".new"))
	}
}

BEGIN{
	supported_patches="0001 0002 0003 0006 0007 0009 0010 0011 0013 0014 0015 0017 0020 0023 0024 0025 0026 0032 0033 0040 0041 0042 0044 0045 0048 0051 0059 0064 0074 0077 0078 0079 0084 0085 0086 0087 0088"
	if (staging) supported_patches=(supported_patches " 0022 ")

	if (supported_patches !~ patch_number) {
		diff_array["exit code"]=255
		exit diff_array["exit code"]
	}
}
{
	file_array[++line] = $0
}
END{
	file_array[0]=line
	process_patch_file(file_array, diff_array)
	if (diff_array["exit code"]) {
		dump_error()
		exit diff_array["exit code"]
	}
}
