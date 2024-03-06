vim.cmd([[
" Taken from https://github.com/jesseleite/dotfiles/blob/c75ae5ebd0589361e1fe84a912f1580a9b1f9a15/vim/plugin-config/fzf.vim#L44-L86
" This adds PHistory and CwdHistory commands, for scoped history finders.

" ------------------------------------------------------------------------------
" # Scoped History Finders
" ------------------------------------------------------------------------------

function! s:file_history_from_directory(directory)
  return fzf#vim#_uniq(filter(fzf#vim#_recent_files(), "s:file_is_in_directory(fnamemodify(v:val, ':p'), a:directory)"))
endfunction

function! s:file_is_in_directory(file, directory)
  return filereadable(a:file) && match(a:file, a:directory . '/') == 0
endfunction

command! -bang PHistory call fzf#run(fzf#wrap(s:preview(<bang>0, {
  \ 'source': s:file_history_from_directory(s:get_git_root()),
  \ 'options': [
  \   '--prompt', 'ProjectHistory> ',
  \   '--multi',
  \ ]}), <bang>0))

command! -bang CwdHistory call fzf#run(fzf#wrap(s:preview(<bang>0, {
  \ 'source': s:file_history_from_directory(getcwd()),
  \ 'options': [
  \   '--prompt', 'CwdHistory> ',
  \   '--multi',
  \ ]}), <bang>0))

" ------------------------------------------------------------------------------
" # Script functions copied from fzf.vim to make above things work
" ------------------------------------------------------------------------------

function! s:preview(bang, ...)
  let preview_window = get(g:, 'fzf_preview_window', a:bang && &columns >= 80 || &columns >= 120 ? 'right': '')
  if len(preview_window)
    return call('fzf#vim#with_preview', add(copy(a:000), preview_window))
  endif
  return {}
endfunction

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction
]])
