-- Custom commands
vim.cmd([[
command! -nargs=? RgProto lua require "functions".rg_proto(<f-args>)
command! -nargs=? RgNotGen lua require "functions".rg_not_gen(<f-args>)
command! -nargs=? RgOnlyGo lua require "functions".rg_only_go(<f-args>)
command! -nargs=? ROG lua require "functions".rg_only_go(<f-args>)
command! -bar ClearQuickfixList cexpr []
command! -bar ToggleFoldColumn lua require "functions".toggle_fold_column()
command! -bar ToggleSetList lua require "functions".toggle_set_list()
command! -bar ToggleFoldMethod lua require "functions".toggle_fold_method()
command! -bar EchoRelativeFilePath echo expand("%")
command! -bar EchoFileName echo expand("%:t")
command! -bar EchoFullFilePath echo expand("%:p")
command! -bar EchoDirName echo expand("%:p:h:t")
command! -bar EchoFullDirPath echo expand("%:p:h")
command! -bar FzfFiles lua require "functions".fzf_files()
]])

