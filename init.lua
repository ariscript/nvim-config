-- most of this config was adapted from https://github.com/nullishamy/nvim-config.
-- thanks amy

local ok, utils = pcall(require, 'utils')

if not ok then
    return vim.notify_once('Failed to load `utils` module. Cannot proceed.')
end

local module = utils.load_module

-- run preload
module 'preload'

-- initialize modules
module 'core/autocmd'
module 'core/keybinds'
module 'theming/colors'
module 'core/editor'

-- core features
module 'core/bufferline'
module 'core/statusline'

-- neovide specific configuration
module 'core/neovide'

-- diagnostics and navigation
module 'plugin/tree'
module 'diagnostic/lsp'

-- snippets must be loaded before cmp
module 'plugin/snippets'
module 'diagnostic/cmp'

-- plugins
module 'plugin/autosave'
module 'plugin/autopairs'
module 'diagnostic/trouble'
module 'plugin/comment'
module 'plugin/leap'
module 'treesitter'
module 'plugin/git'
module 'diagnostic/lsp_colors'
module 'plugin/todo'
module 'plugin/focus'
module 'plugin/whichkey'
module 'plugin/gui'
module 'plugin/scroll'
module 'plugin/toggleterm'
