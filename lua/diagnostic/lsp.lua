require('nvim-lsp-installer').setup({
    ui = {
        check_outdated_servers_on_open = false,
    },
})

local lsp = require 'lspconfig'

local on_attach = function(_, buf)
    local opts = { noremap = true, silent = true }
    local set = vim.api.nvim_buf_set_keymap

    set(buf, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    set(buf, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set(buf, 'n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    set(buf, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    set(buf, '', '<leader>i', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    set(buf, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    set(buf, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    set(buf, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    set(buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    set(buf, '', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
    tsserver = {},
    bashls = {},
    cssls = {},
    dockerls = {},
    jsonls = {},
    hls = {},
    rust_analyzer = {
        cmd = { 'rust-analyzer' }
    },
    pyright = {},
    clangd = {},
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';')
                },
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- make the server aware of neovim runtime files
                library = {
                    vim.fn.expand('$VIMRUNTIME/lua'),
                    vim.fn.stdpath('config') .. '/lua',
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
    html = {},
}

for server, config in pairs(servers) do
    config.autostart = true
    config.on_attach = on_attach
    config.capabilities = capabilities
    lsp[server].setup(config)
end

require('rust-tools').setup({
    server = {
        autostart = true,
        on_attach,
        capabilities,
    },
    -- amy disabled inlay hints here
    -- i might do the same if they arent helpful
})

local border = require('utils').border

-- configure borders
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border('FloatBorder'),
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
    border = border('FloatBorder')
})
