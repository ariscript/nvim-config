-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

-- init packer
return require('packer').startup(function(use)
    -- theme
    use 'navarasu/onedark.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    -- completions
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'p00f/nvim-ts-rainbow' -- bracket pair colors

    -- language tools
    use 'simrat39/rust-tools.nvim'
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    -- snippets
    use 'honza/vim-snippets'
    use 'L3MON4D3/LuaSnip'

    -- diagnostics
    use 'nullishamy/trouble.nvim' -- line wrapping enabled

    -- util
    use 'Pocco81/AutoSave.nvim'
    use 'jghauser/mkdir.nvim'
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end,
    }
    use 'nvim-neo-tree/neo-tree.nvim'
    use 'ggandor/leap.nvim'
    use 'windwp/nvim-autopairs'
    use 'folke/todo-comments.nvim'
    use 'beauwilliams/focus.nvim'
    use 'famiu/bufdelete.nvim'
    use 'MunifTanjim/nui.nvim'

    -- tpope
    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    -- misc
    use 'nvim-lua/plenary.nvim'
    use 'wbthomason/packer.nvim'
    use 'sheerun/vim-polyglot'
    use 'folke/which-key.nvim'
    use 'karb94/neoscroll.nvim'
    use 'akinsho/toggleterm.nvim'

    -- selection
    use 'nvim-telescope/telescope.nvim'
    use 'stevearc/dressing.nvim'

    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true,
        },
    }

    -- bufferline
    use 'noib3/nvim-cokeline'

    -- git
    use 'lewis6991/gitsigns.nvim'

    -- sessions
    use 'Shatur/neovim-session-manager'

    if packer_bootstrap then
        -- if we just bootstrapped, sync
        -- install packer as a dependency and the other plugins
        require('packer').sync()
    end
end)
