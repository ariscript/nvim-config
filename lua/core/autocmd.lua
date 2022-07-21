-- relative line numbers in normal mode
-- absolute line numbers in insert mode
vim.cmd([[
    :augroup numberToggle
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    :augroup end
]])

-- don't autocomment new lines
vim.cmd([[
    autocmd BufEnter * set fo-=c fo-=r fo-=o
]])

-- disable annyoing autoindent rules
vim.cmd([[ 
    autocmd BufEnter,WinEnter,FocusGained * set nocin nosi inde= 
]])

-- disable highlight searching for every buffer
vim.cmd([[
    autocmd BufEnter,WinEnter,FocusGained * set nohlsearch
]])

-- recompile packer config when it changes
vim.cmd([[
    autocmd BufWritePost preload.lua source <afile> | PackerCompile
]])

-- set colors when floats open, overwrite color scheme implementations
vim.cmd([[
    autocmd! ColorScheme * highlight NormalFloat guifg=white guibg=#1a212e 
]])
vim.cmd([[
    autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1a212e
]])
