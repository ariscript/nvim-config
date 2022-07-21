local g = vim.g -- global variables
local opt = vim.opt -- set options
local o = vim.o

-- general
o.completeopt = 'menu,noinsert,noselect,preview'
g.noshowmode = true
g.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.updatetime = 250
o.mouse = 'a'
opt.scrolloff = 12 -- keep 12 lines of context on either side of cursor
vim.wo.number = true

-- memory and CPU
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember 100 lines of history
opt.lazyredraw = true -- faster scroll
opt.synmaxcol = 240 -- max column for syntax highlighting
opt.updatetime = 700 -- ms to wait for trigger an event

-- disable builtins plugins
local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
    g['loaded_' .. plugin] = 1
end
