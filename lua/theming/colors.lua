vim.o.termguicolors = true
vim.o.background = 'dark'

-- enable italics for comments etc
vim.g.one_allow_italics = 1

require('onedark').setup({
    style = 'deep',
    -- no-op bind because interferes with other binds by default
    toggle_style_key = '<F20>',
})
require('onedark').load()
