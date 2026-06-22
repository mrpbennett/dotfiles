" autoload/db/adapter/trino.vim

function! s:cmd(url) abort
  let parsed = db#url#parse(a:url)
  let host   = get(parsed, 'host', 'localhost')
  let port   = get(parsed, 'port', '8080')
  let params = get(parsed, 'params', {})

  " SSL param → https
  let scheme = (get(params, 'SSL', '0') ==? 'true' || get(params, 'secure', '0') ==# '1')
        \ ? 'https' : 'http'
  let cmd = ['trino', '--server', scheme . '://' . host . ':' . port]

  " catalog/schema from path
  let parts = split(get(parsed, 'path', ''), '/')
  if len(parts) >= 1 && !empty(parts[0])
    let cmd += ['--catalog', parts[0]]
  endif
  if len(parts) >= 2 && !empty(parts[1])
    let cmd += ['--schema', parts[1]]
  endif

  " User
  let user = get(parsed, 'user', '')
  if !empty(user)
    let cmd += ['--user', user]
  endif

  " Password — trino CLI reads $TRINO_PASSWORD; set it here
  let password = get(parsed, 'password', '')
  if !empty(password)
    let $TRINO_PASSWORD = password
    let cmd += ['--password']
  elseif !empty($TRINO_PASSWORD)
    let cmd += ['--password']
  endif

  " Extra session properties from ?session=key=val
  for [k, v] in items(params)
    if k ==# 'session'
      let cmd += ['--session', v]
    endif
  endfor

  return cmd
endfunction

function! db#adapter#trino#canonicalize(url) abort
  return a:url
endfunction

function! db#adapter#trino#massage(str) abort
  let str = substitute(a:str, '\s\+$', '', '')
  if str !~# ';$'
    let str .= ';'
  endif
  return str
endfunction

function! db#adapter#trino#interactive(url) abort
  return s:cmd(a:url)
endfunction

function! db#adapter#trino#input(url, file) abort
  if filereadable(a:file)
    let lines = readfile(a:file)
    let i = len(lines) - 1
    while i >= 0 && lines[i] =~# '^\s*$'
      let i -= 1
    endwhile
    if i >= 0 && lines[i] !~# ';\s*$'
      let lines[i] = lines[i] . ';'
      call writefile(lines, a:file)
    endif
  endif
  return s:cmd(a:url) + ['--no-progress', '--output-format', 'ALIGNED', '--file', a:file]
endfunction

function! db#adapter#trino#complete_database(url) abort
  let parsed = db#url#parse(a:url)
  let parts = split(get(parsed, 'path', ''), '/')
  let q = len(parts) >= 1 && !empty(parts[0]) ? 'SHOW SCHEMAS' : 'SHOW CATALOGS'
  return db#systemlist(s:cmd(a:url) + ['--no-progress', '--output-format', 'TSV', '--execute', q])
endfunction

function! db#adapter#trino#tables(url) abort
  let parsed = db#url#parse(a:url)
  let parts = split(get(parsed, 'path', ''), '/')
  if len(parts) >= 2 && !empty(parts[1])
    let q = 'SHOW TABLES'
  else
    let q = 'SELECT table_schema || ''.'' || table_name FROM information_schema.tables WHERE table_schema NOT IN (''information_schema'') ORDER BY 1'
  endif
  return db#systemlist(s:cmd(a:url) + ['--no-progress', '--output-format', 'TSV', '--execute', q])
endfunction
