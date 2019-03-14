#!/usr/bin/env awk

function process_staging_patch_file_0001(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/configure") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("-243 0 -243 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 2) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("-137 0 -137 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 3) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("-137 0 -137 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/configure.ac") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 3)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("-3 0 -3 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 2) && (complete >= 4)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("47 0 47 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 3) && (complete >= 5)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("47 0 47 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 6) exit_code=idiff
}

function process_patch_file_0002(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("0 -1 0 -1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ "^ #define SERVER_PROTOCOL_VERSION [[:digit:]][[:digit:]][[:digit:]]$")) {
					delete file_array[line]
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/trace.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index != 7) {
						++idiff
						++complete
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"), "(dump_func)dump_exec_process_request,", file_array[line])) {
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0002(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/esync.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("0 0 0 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+ no_open_file, /* open_file */$"))) {
					line_text = ("+" substr(indent, 2) "no_alloc_handle,           /* alloc_handle */")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/protocol.def") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("113 2 113 2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+@END$"))) {
					line_text = " "
					insert_array_entry(file_array, ++line, line_text)
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0003(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/server.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(server);$"))) {
					line_text = (" WINE_DECLARE_DEBUG_CHANNEL(winediag);")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}			
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0006(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/om.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ "^ #include \"wine/server.h\"$")) {
					line_text = " "
					file_array[++line] = line_text
					line_text = (indent "WINE_DEFAULT_DEBUG_CHANNEL(ntdll);")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
			
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_staging_patch_file_0006(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/om.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ "^ #include \"wine/exception.h\"$")) {
					line_text = (indent "#include \"wine/unicode.h\"")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
			
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0009(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/sync.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index <= 8) {
						idiff += 5
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						sub(text2regexp("NTSTATUS WINAPI NtSetEvent( HANDLE handle, PULONG NumberOfThreadsReleased )$"), "NTSTATUS WINAPI NtOpenEvent( HANDLE *handle, ACCESS_MASK access, const OBJECT_ATT", file_array[line])
						split("+57 0 +57 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 2) {
					if (file_array[line-1] ~ text2regexp(" @@ NTSTATUS WINAPI NtOpenEvent(*")) {
						line_text = (indent "NTSTATUS WINAPI NtSetEvent( HANDLE handle, LONG *prev_state )")
						insert_array_entry(file_array, line, line_text)
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 3) {
					if ((esync_rebase_index <= 8) || ((esync_rebase_index == 9) && !staging)) {
						idiff += 1
					}
					else if (file_array[line] ~ text2regexp("^     NTSTATUS ret;$")) {
						delete file_array[++line]
						++idiff
					}
				}
				else if (idiff == 4) {
					if (esync_rebase_index <= 8) {
						idiff += 1
						++complete
					}
					else if (file_array[line] ~ text2regexp("/* FIXME: set NumberOfThreadsReleased */$")) {
						if ((esync_rebase_index == 9) && !staging) {
							++idiff
							++complete
						}
						else {
							delete file_array[line]
							delete file_array[++line]
							++line
							line_text=(indent "{")
							insert_array_entry(file_array, ++line, line_text)
							line_text=(indent indent "req->handle = wine_server_obj_handle( handle );")
							insert_array_entry(file_array, ++line, line_text)
							++idiff
							++complete
						}
					}
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0010(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/sync.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index <= 8) {
						idiff += 4
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
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 2) {
					if ((esync_rebase_index <= 8) || ((esync_rebase_index == 9) && !staging)) {
						++idiff
					}
					else if (file_array[line] ~ text2regexp("NTSTATUS ret;$")) {
						delete file_array[++line]
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 3) {
					if ((esync_rebase_index <= 8) || ((esync_rebase_index == 9) && !staging)) {
						++idiff
					}
					else if (sub(text2regexp("/* resetting an event can't release any thread... */$"), "SERVER_START_REQ( event_op )", file_array[line])) {
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 4) {
					if (file_array[line] ~ text2regexp("if (NumberOfThreadsReleased) *NumberOfThreadsReleased = 0;$")) {
						if ((esync_rebase_index == 9) && !staging) {
							line_text="if (prev_state) *prev_state = 0;"
							file_array[line]=(indent line_text)
							file_array[++line]=" "
						}
						else {
							line_text="{"
							file_array[line]=(indent line_text)
							line_text= "req->handle = wine_server_obj_handle( handle );"
							file_array[++line]=(indent indent line_text)
						}
						++idiff
						++complete
					}
					exit_end_line=line
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0011(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/sync.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index <= 8) {
						idiff += 2
						++complete
					}
					else if (sub(text2regexp("NTSTATUS WINAPI NtPulseEvent( HANDLE handle, PULONG PulseCount )$"), "NTSTATUS WINAPI NtPulseEvent( HANDLE handle, LONG *prev_state )", file_array[line])) {
						++idiff
					}
					exit_end_line=line
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^     if (PulseCount)")) {
						line_text=(indent "SERVER_START_REQ( event_op )")
						file_array[line] = line_text
						line_text=(indent "{")
						file_array[++line] = line_text
						line_text=(indent indent "req->handle = wine_server_obj_handle( handle );")
						file_array[++line] = line_text
						++idiff
						++complete
					}
					exit_end_line=line
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0013(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/named_pipe.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (1) {
						++idiff
						++complete
					}
					else if (sub(text2regexp("named_pipe_device_get_fd, /* get_fd */"), "no_get_fd,                        /* get_fd */", file_array[line])) {
						++idiff
						++complete
					}
					exit_end_line=line
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0014(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_count, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					saved_line=line
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^*#define SERVER_PROTOCOL_VERSION "))) {
					line_count=0
					while(!is_new_diff_file(file_array[line])) {
						delete file_array[line]
						++line
						line_count-=1
					}
					if (saved_line) {
						split(("371 " line_count " 371 " line_count), array_diff_lines)
						change_array_entry_diff(file_array, saved_line, array_diff_lines)
					}
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/trace.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index != 7) {
						++idiff
						++complete
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"), "(dump_func)dump_exec_process_request,", file_array[line])) {
						++idiff
						++complete
					}
					exit_end_line=line
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0014(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (1) {
						idiff += 3
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("-401 0 -401 0", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if ((idiff == 2) && sub(text2regexp("struct set_job_completion_port_reply set_job_completion_port_reply;$"), "struct suspend_process_reply suspend_process_reply;", file_array[line])) {
					++idiff
				}
				else if ((idiff == 3) && sub(text2regexp("struct terminate_job_reply terminate_job_reply;$"), "struct resume_process_reply resume_process_reply;", file_array[line])) {
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/protocol.def") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("113 2 113 2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+@END$"))) {
					line_text = " "
					insert_array_entry(file_array, ++line, line_text)
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_patch_file_0015(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/process.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 5) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && !staging && (esync_rebase_index >= 6)) {
					++idiff
					++complete
				}
				else if ((idiff == 1) && (file_array[line] ~ text2regexp("^ set_fd_events( process->msg_fd, POLLIN );  /* start listening to events */$"))) {
					line_text = (indent "/* create the main thread */")
					file_array[line] = line_text
					line_text = (indent "if (pipe( request_pipe ) == -1)")
					file_array[++line] = line_text
					line_text = (indent "{")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_staging_patch_file_0015(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/process.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && sub(text2regexp("^ static unsigned int process_map_access( struct object *obj, unsigned int access );$"), " static struct security_descriptor *process_get_sd( struct object *obj );", file_array[line])) {
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 5) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ if (!token_assign_label( process->token, security_high_label_sid ))$"))) {
					line_text = (indent "}")
					file_array[line] = line_text
					line_text = (indent "if (!process->handles || !process->token) goto error;")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0017(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/event.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 3) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("0 1 0 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ no_open_file, /* open_file */$"))) {
					line_text = (indent "no_alloc_handle,           /* alloc_handle */")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0020(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging && (esync_rebase_index <= 8)) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						delete file_array[++line]
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^ static void dump_thread( struct object *obj, int verbose );$")) {
						line_text = (indent "static struct object_type *thread_get_type( struct object *obj );")
						insert_array_entry(file_array, ++line, line_text)
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 3) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 -2 0 -2", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^+ thread->esync_fd = -1;$")) {
						line_text = (indent "thread->exit_poll       = NULL;")
						file_array[++line] = line_text
						delete file_array[++line]
						delete file_array[++line]
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 5) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 1 0 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^ if (thread->id) free_ptid( thread->id );$")) {
						line_text = (indent "if (thread->exit_poll) remove_timeout_user( thread->exit_poll );")
						insert_array_entry(file_array, line, line_text)
						++line
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 6) && (complete >= 3)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging) {
						idiff += 1
						++complete
					}
					else if ((esync_rebase_index <= 8) && sub(text2regexp("return (mythread->state == TERMINATED);$"), "return (mythread->state == TERMINATED \\&\\& !mythread->exit_poll);", file_array[line])) {
						++idiff
						++complete
					}
					else if (sub(text2regexp("return (mythread->state == TERMINATED);$"), "return mythread->state == TERMINATED \\&\\& !mythread->exit_poll;", file_array[line])) {
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/thread.h") {
			if (!exit_start_line)
				exit_start_line=line
			if (diff_file)
				exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 4)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 -2 0 -2", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^+ int esync_fd; /* esync file descriptor (signalled on exit) */$")) {
						line_text = (indent "struct timeout_user   *exit_poll;     /* poll if the thread/process has exited already */")
						file_array[++line] = line_text
						delete file_array[++line]
						delete file_array[++line]
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 5) exit_code=idiff
}

function process_staging_patch_file_0022(file_array,
	array_diff_lines, complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])

		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/queue.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ struct thread_input *input; /* thread input descriptor */$"))) {
					delete file_array[line]
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ timeout_t              last_get_msg; /* time of last get message call */$"))) {
					line_text = (indent "unsigned int           ignore_post_msg; /* ignore post messages newer than this unique id */")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
					exit_end_line=line
				}
			}
			else if ((ihunk == 5) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ queue->input = (struct thread_input *)grab_object( input );$"))) {
					delete file_array[line]
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ queue->last_get_msg = current_time;$"))) {
					line_text = (indent "queue->ignore_post_msg = 0;")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 3) && sub(text2regexp("if (new_input) release_object( new_input );$"), "if (new_input)", file_array[line])) {
					++idiff
					++complete
					exit_end_line=line
				}
			}
			else if ((ihunk == 6) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("50 -2 50 -2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ queue->wake_bits &= ~bits;$"))) {
					delete file_array[line-1]
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 3) && (file_array[line] ~ text2regexp("^ queue->changed_bits &= ~bits;$"))) {
					line_text = (indent "update_shm_queue_bits( queue );")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 4) && (file_array[line] ~ text2regexp("^ /* check whether msg is a keyboard message */$"))) {
					delete file_array[line-1]
					delete file_array[line]
					++idiff
					++complete
					exit_end_line=line
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 3) exit_code=idiff
}

function process_patch_file_0023(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/ntdll.spec") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					if (staging)
						split("15 1 15 1", array_diff_lines)
					else
						split("-13 1 -13 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+@ cdecl __wine_esync_set_queue_fd(long)$"))) {					
					if (staging) {
						if (esync_rebase_index == 0)
							line_text=" @ cdecl __wine_user_shared_data()"
						else
							line_text = " "
					}
					else {
						line_text=" @ cdecl __wine_init_windows_dir(wstr wstr)"
					}
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
					exit_end_line=line
				}				
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_staging_patch_file_0023(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/ntdll.spec") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("-4 2 -4 2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+@ cdecl __wine_esync_set_queue_fd(long)$"))) {
					line_text = " "
					insert_array_entry(file_array, ++line, line_text)
					line_text = " # User shared data"
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
					exit_end_line=line
				}
			}
		}
		else if (diff_file == "/dlls/ntdll/ntdll_misc.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ int wait_fd[2]; /* fd for sleeping server requests */$"))) {
					delete file_array[line]
					++idiff
					exit_end_line=line
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+ int esync_queue_fd;/* fd to wait on for driver events */"))) {
					line_text = (indent "void              *pthread_stack; /* pthread stack */")
					insert_array_entry(file_array, line, line_text)
					++line
					++idiff
					++complete
					exit_end_line=line
				}
			}
		}
		else if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 2) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (esync_rebase_index <= 4)) {
					idiff += 3
					++complete
				}
				else if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("171 0 171 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && sub(text2regexp("pthread_attr_init( &attr );$"), "pthread_attr_init( \\&pthread_attr );", file_array[line])) {
					++idiff
				}
				else if ((idiff == 3) && sub(text2regexp("pthread_attr_setstack( &attr, teb->DeallocationStack,$"), "pthread_attr_setstack( \\&pthread_attr, teb->DeallocationStack,", file_array[line])) {
					++idiff
					++complete
				}
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 3) exit_code=idiff
}

function process_patch_file_0024(file_array,
	complete, diff_file, idiff, ihunk, indent, line, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging && (esync_rebase_index <= 8)) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 1 0 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^ static void dump_thread( struct object *obj, int verbose );$")) {
						line_text=" static struct object_type *thread_get_type( struct object *obj );"
						insert_array_entry(file_array, ++line, line_text)
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 2) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (!staging) {
						idiff += 1
						++complete
					}
					else if ((esync_rebase_index <= 8) && sub(text2regexp("return (mythread->state == TERMINATED);$"), "return (mythread->state == TERMINATED \\&\\& !mythread->exit_poll);", file_array[line])) {
						++idiff
						++complete
					}
					else if (sub(text2regexp("return (mythread->state == TERMINATED);$"), "return mythread->state == TERMINATED \\&\\& !mythread->exit_poll;", file_array[line])) {
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/trace.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if ((esync_rebase_index >= 9) || (staging && (esync_rebase_index != 7))) {
						idiff += 1
						++complete
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"), "(dump_func)dump_exec_process_request,", file_array[line])) {
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 3) exit_code=idiff
}

function process_staging_patch_file_0024(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/process.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("0 1 0 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ static unsigned int process_map_access( struct object *obj, unsigned int access );$"))) {
					line_text=" static struct security_descriptor *process_get_sd( struct object *obj );"
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/protocol.def") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("113 2 113 2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^+};$"))) {
					line_text = " "
					insert_array_entry(file_array, ++line, line_text)
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0025(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/server/device.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 6) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("8 2 8 2", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("struct device *device = LIST_ENTRY( ptr, struct device, entry );$"))) {
					line_text = (indent "grab_object( &device->obj );")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
				}
				else if ((idiff == 3) && (file_array[line] ~ text2regexp("^ delete_device( device );$"))) {
					line_text = (indent "release_object( &device->obj );")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
			}
			exit_end_line=line
		}
	}

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0033(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("308 -3 308 -3", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION "))) {
					while(!is_new_diff_file(file_array[line]))
						delete file_array[line++]
					++idiff
					++complete
				}
			}
			exit_end_line=line
		}
	}

	if (complete != 1) exit_code=idiff
}

function process_patch_file_0041(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	diff_offset=staging ? -28 : -58
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split((diff_offset " 2 " diff_offset " 2"), array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					line_text=" struct create_esync_reply"
					insert_array_entry(file_array, ++line, line_text)
					line_text=" {"
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
			else if ((ihunk == 2) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split((diff_offset " 2 " diff_offset " 2"), array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					line_text=" struct open_esync_reply"
					insert_array_entry(file_array, ++line, line_text)
					line_text=" {"
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0041(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/main.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("1 1 1 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ init_signals();$"))) {
					line_text = (indent "init_scheduler();")
					insert_array_entry(file_array, line, line_text)
					++line
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 1) exit_code=idiff
}

function process_patch_file_0042(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (esync_rebase_index >= 1)) {
					++idiff
					++complete
				}
				else if ((idiff == 1) && (file_array[line] ~ text2regexp("^ WINE_DEFAULT_DEBUG_CHANNEL(thread);$"))) {
					line_text=(" " "WINE_DECLARE_DEBUG_CHANNEL(relay);")
					file_array[++line] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
			if ((ihunk == 2) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$"))) {
					line_text=" "
					file_array[++line] = line_text
					line_text = (indent "return exe_file;")
					file_array[++line] = line_text
					while(file_array[++line] ~ "^[[:blank:]]*$")
						delete file_array[line]
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0042(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && is_new_hunk(file_array[line])) {
					split("163 0 163 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ fill_cpu_info();$"))) {
					line_text = (indent "__wine_user_shared_data();")
					file_array[line-1] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 1) exit_code=idiff
}

function process_patch_file_0045(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("283 -3 283 -3", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION "))) {
					while(!is_new_diff_file(file_array[line]))
						delete file_array[line++]
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/trace.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (esync_rebase_index != 7)) {
					++idiff
					++complete
				}
				else if ((idiff == 1) && sub(text2regexp("(dump_func)dump_get_new_process_info_request,"), "(dump_func)dump_exec_process_request,", file_array[line])) {
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0045(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk;
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/ntdll_misc.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("49 1 49 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ int esync_queue_fd;/* fd to wait on for driver events */$"))) {
					line_text = (indent "void              *pthread_stack; /* pthread stack */")
					insert_array_entry(file_array, line, line_text)
					++line
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 2) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("171 0 171 0", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (esync_rebase_index <= 4)) {
					idiff += 2
					++complete
				}
				else if ((idiff == 2) && sub(text2regexp("pthread_attr_init( &attr );$"), "pthread_attr_init( \\&pthread_attr );", file_array[line])) {
					++idiff
				}
				else if ((idiff == 3) && sub(text2regexp("pthread_attr_setstack( &attr, teb->DeallocationStack,$"), "pthread_attr_setstack( \\&pthread_attr, teb->DeallocationStack,", file_array[line])) {
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^+ thread->esync_apc_fd = -1;$"))) {
					line_text="thread->exit_poll       = NULL;"
					file_array[++line]=(indent line_text)
					line_text="thread->shm_fd          = -1;"
					file_array[++line]=(indent line_text)
					line_text="thread->shm             = NULL;"
					file_array[++line]=(indent line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if (diff_file == "/server/thread.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if ((ihunk == 1) && (complete >= 3)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^+ int esync_apc_fd; /* esync apc fd (signalled when APCs are present) */$"))) {
					line_text="struct timeout_user   *exit_poll;     /* poll if the thread/process has exited already */"
					file_array[++line]=(indent line_text)
					line_text="int                    shm_fd;        /* file descriptor for thread local shared memory */"
					file_array[++line]=(indent line_text)
					line_text="shmlocal_t            *shm;           /* thread local shared memory pointer */"
					file_array[++line]=(indent line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 4) exit_code=idiff
}

function process_patch_file_0048(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/kernel32/tests/sync.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && sub(text2regexp("ERROR_INVALID_PARAMETER"), "ERROR_FILE_NOT_FOUND", file_array[line])) {
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 1) exit_code=idiff
}

function process_patch_file_0064(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/fd.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 2) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index >= 9) {
						idiff += 2
						++complete
					}
					else if (is_new_hunk(file_array[line])) {
						split("0 1 0 1", array_diff_lines)
						change_array_entry_diff(file_array, line, array_diff_lines)
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^ apc_param_t comp_key; /* completion key to set in completion events */$")) {
						line_text = (indent "unsigned int         comp_flags;  /* completion flags */")
						insert_array_entry(file_array, ++line, line_text)
						++idiff
						++complete
					}
				}
			}
			else if ((ihunk == 4) && (complete >= 1)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index >= 9) {
						idiff += 2
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ fd->fs_locks = 1;$")) {
						delete file_array[line]
						++idiff
					}
				}
				else if (idiff == 2) {
					if (file_array[line] ~ text2regexp("^ fd->completion = NULL;$")) {
						line_text = (indent "fd->comp_flags = 0;")
						insert_array_entry(file_array, ++line, line_text)
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 5) && (complete >= 2)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index >= 9) {
						idiff += 1
						++complete
					}
					else if (file_array[line] ~ text2regexp("^ fd->poll_index = -1;$")) {
						line_text = (indent "fd->completion = NULL;")
						file_array[line] = line_text
						line_text = (indent "fd->comp_flags = 0;")
						file_array[++line] = line_text
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
			else if ((ihunk == 6) && (complete >= 3)) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index <= 8) {
						idiff += 1
						++complete
					}
					else if (file_array[line] ~ text2regexp("fd->signaled = signaled;$")) {
						line_text = (indent "if (fd->comp_flags & FILE_SKIP_SET_EVENT_ON_HANDLE) return;")
						file_array[line-1] = line_text
						++idiff
						++complete
					}
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 4) exit_code=idiff
}

function process_patch_file_0074(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ NtCreateKeyedEvent( &keyed_event, GENERIC_READ | GENERIC_WRITE, NULL, 0 );$"))) {
					line_text = " "
					if (esync_rebase_index == 6)
						file_array[++line] = line_text
					else
						insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 1) exit_code=idiff
}

function process_staging_patch_file_0074(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/dlls/ntdll/thread.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (file_array[line] ~ text2regexp("^ fill_cpu_info();$"))) {
					line_text = (indent "__wine_user_shared_data();")
					file_array[line-1] = line_text
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line
	
	if (complete != 1) exit_code=idiff
}

function process_patch_file_0079(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/include/wine/server_protocol.h") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 4) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("306 -3 306 -3", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^-#define SERVER_PROTOCOL_VERSION "))) {
					while(!is_new_diff_file(file_array[line]))
						delete file_array[line++]
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
		else if ((diff_file == "/server/trace.c") && (complete >= 1)) {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if (idiff == 1) {
					if (esync_rebase_index != 7) {
						++idiff
					}
					else if (sub(text2regexp("(dump_func)dump_get_new_process_info_request,"), "(dump_func)dump_exec_process_request,", file_array[line])) {
						++idiff
					}
				}
			}
			else if (ihunk == 4) {
				if (idiff == 1) {
					if (esync_rebase_index >= 6) {
						++idiff
						++complete
					}
					else if ((idiff == 1) && (file_array[line] ~ text2regexp("^-- $"))) {
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
						++idiff
						++complete
					}
				}
			}
			exit_end_line=line
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 2) exit_code=idiff
}

function process_staging_patch_file_0079(file_array,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == "/server/queue.c") {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == 1) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					split("6 1 6 1", array_diff_lines)
					change_array_entry_diff(file_array, line, array_diff_lines)
					++idiff
				}
				else if ((idiff == 2) && (file_array[line] ~ text2regexp("^ timeout_t last_get_msg; /* time of last get message call */$"))) {
					line_text = (indent "unsigned int           ignore_post_msg; /* ignore post messages newer than this unique id */")
					insert_array_entry(file_array, ++line, line_text)
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file_delete_target_hunk(file_array, target_diff_file, target_hunk,
	complete, diff_file, idiff, ihunk, indent, line, line_text, new_diff_file)
{
	exit_start_line=0
	for (line = 1 ; line <= file_array[0] ; ++line) {
		indent = get_indent(file_array[line])
		if (new_diff_file = is_new_diff_file(file_array[line])) {
			diff_file = new_diff_file
			idiff=1
			ihunk=0
		}
		else if (is_new_hunk(file_array[line])) {
			++ihunk
			idiff=1
		}

		if (diff_file == target_diff_file) {
			exit_start_line=exit_start_line ? exit_start_line : line
			exit_diff_file=diff_file

			if (ihunk == target_hunk) {
				exit_hunk=ihunk
				if (is_new_hunk(file_array[line])) exit_start_line=line
				if ((idiff == 1) && (is_new_hunk(file_array[line]))) {
					while(!is_new_diff_file(file_array[line]))
						delete file_array[line++]
					++idiff
					++complete
				}
				exit_end_line=line
			}
		}
	}

	if (!exit_end_line) exit_end_line=line

	if (complete != 1) exit_code=idiff
}

function process_patch_file(file_array)
{
	printf("Pre-processing patch file: '%s' ...\n", file_name)

	if (staging && (patch_number == "0001") && (esync_rebase_index <= 2)) {
		process_staging_patch_file_0001(file_array)
	}
	else if (patch_number == "0002") {
		process_patch_file_0002(file_array)
		if (!exit_code && staging) process_staging_patch_file_0002(file_array)
	}
	else if (staging && (patch_number == "0003")) {
		process_staging_patch_file_0003(file_array)
	}
	else if (patch_number == "0006") {
		if (!staging && (esync_rebase_index <= 2))
			process_patch_file_0006(file_array)
		else if (staging)
			process_staging_patch_file_0006(file_array)
	}
	else if (patch_number == "0009") {
		process_patch_file_0009(file_array)
	}
	else if (patch_number == "0010") {
		process_patch_file_0010(file_array)
	}
	else if (patch_number == "0011") {
		process_patch_file_0011(file_array)
	}
	else if (patch_number == "0013") {
		process_patch_file_0013(file_array)
	}
	else if (patch_number == "0014") {
		process_patch_file_0014(file_array)
		if (!exit_code && staging) process_staging_patch_file_0014(file_array)
	}
	else if (patch_number == "0015") {
		if (esync_rebase_index <= 5)
			process_patch_file_0015(file_array)
		if (!exit_code && staging) process_staging_patch_file_0015(file_array)
	}
	else if (staging && (patch_number == "0017")) {
		process_staging_patch_file_0017(file_array)
	}
	else if (patch_number == "0020") {
		process_patch_file_0020(file_array)
	}
	else if (staging && (patch_number == "0022")) {
		process_staging_patch_file_0022(file_array)
	}
	else if (patch_number == "0023") {
		if (esync_rebase_index == 0)
			process_patch_file_0023(file_array)
		if (!exit_code && staging) process_staging_patch_file_0023(file_array)
	}
	else if (patch_number == "0024") {
		if ((esync_rebase_index == 7) || (esync_rebase_index >= 9) || staging)
			process_patch_file_0024(file_array)
		if (!exit_code && staging)
			process_staging_patch_file_0024(file_array)
		if (!exit_code && (esync_rebase_index <= 7))
			process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if (staging && (patch_number == "0025")) {
		process_staging_patch_file_0025(file_array)
	}
	else if ((patch_number == "0026") && (esync_rebase_index <= 7)) {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if ((patch_number == "0032") && (esync_rebase_index <= 7)) {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if ((patch_number == "0033") && (esync_rebase_index <= 7)) {
		process_patch_file_0033(file_array)
	}
	else if (patch_number == "0040") {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0041") {
		process_patch_file_0041(file_array)
		if (!exit_code && staging)
			process_staging_patch_file_0041(file_array)
		if (!exit_code)
			process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 3)
	}
	else if (patch_number == "0042") {
		if (esync_rebase_index <= 6)
			process_patch_file_0042(file_array)
		if (!exit_code && staging)
			process_staging_patch_file_0042(file_array)
	}
	else if (patch_number == "0044") {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0045") {
		process_patch_file_0045(file_array)
		if (!exit_code && staging) process_staging_patch_file_0045(file_array)
	}
	else if (patch_number == "0048") {
		if ((esync_rebase_index <= 1) || (staging && (esync_rebase_index == 2)))
			process_patch_file_0048(file_array)
	}
	else if (patch_number == "0064") {
		if ((staging && (esync_rebase_index <= 6)) || (esync_rebase_index == 7) || (esync_rebase_index >= 9))
			process_patch_file_0064(file_array)
	}
	else if (patch_number == "0074") {
		if (esync_rebase_index <= 6)
			process_patch_file_0074(file_array)
		if (!exit_code && staging) process_staging_patch_file_0074(file_array)
	}
	else if (patch_number == "0077") {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0078") {
		process_patch_file_delete_target_hunk(file_array, "/include/wine/server_protocol.h", 2)
	}
	else if (patch_number == "0079") {
		process_patch_file_0079(file_array)
		if (!exit_code && staging) process_staging_patch_file_0079(file_array)
	}

	if (exit_code) return exit_code


	if (target_esync_directory) {
		print_file(file_array, (target_esync_directory "/" file_name))
	}
	else
		print_file(file_array, (file_path ".new"))
}

BEGIN{
	supported_patches="0002 0006 0009 0010 0011 0013 0014 0015 0020 0023 0024 0026 0032 0033 0040 0041 0042 0044 0045 0048 0064 0074 0077 0078 0079"
	if (staging) supported_patches=(supported_patches " 0001 0003 0017 0022 0025")
}
{
	if (FNR == 1) {
		file_path = FILENAME
		file_name = get_file_name(file_path)
		patch_number = substr(file_name,1,4)
 		if (supported_patches !~ patch_number) {
			exit_code=255
			exit exit_code
		}
	}

	file_array[++line]=$0
}
END{
	if (line) {
		file_array[0]=line
		process_patch_file(file_array)
	}

	if (exit_code) {
		dump_error()
		exit exit_code
	}
}
