local utils = require 'utils'
local map = utils.map
local abbrev = utils.abbrev

-- space is leader
map('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- quick exit from insert mode
map('i', 'jk', '<Esc>')

-- disable arrow keys in normal mode
map('n', '<Up>', '<Nop>')
map('n', '<Down>', '<Nop>')
map('n', '<Left>', '<Nop>')
map('n', '<Right>', '<Nop>')

-- buffer controls
map('', '<C-h>', '<Plug>(cokeline-focus-prev)')
map('', '<C-l>', '<Plug>(cokeline-focus-next)')
map('', '<Leader>q', '<cmd>Bdelete<cr>')

-- navigation controls
map('', '<Leader>ff', ':Telescope find_files<CR>')
map('', '<Leader>o', ':Telescope buffers<CR>')
map('', '<Leader>g', ':Neotree focus reveal<CR>')

-- hard close with ctrl-q + q
map('n', '<C-q>q', ':qa!<CR>')

-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('t', 'jk', '<C-\\><C-n>')
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- trouble
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

-- sessions
map('n', '<Leader>sl', '<cmd>SessionManager load_session<cr>')
map('n', '<Leader>sd', '<cmd>SessionManager delete_session<cr>')
map('n', '<Leader>ss', '<cmd>SessionManager save_current_session<cr>')

-- focus
map('n', '<leader>h', ':FocusSplitLeft<CR>')
map('n', '<leader>j', ':FocusSplitDown<CR>')
map('n', '<leader>k', ':FocusSplitUp<CR>')
map('n', '<leader>l', ':FocusSplitRight<CR>')

-- abbreviations
abbrev('Git', 'Neotree focus source=git_status position=float')
abbrev('Grep', 'lua require(\'telescope.builtin\').live_grep()')
