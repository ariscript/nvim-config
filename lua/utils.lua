local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.abbrev(from, to, opts)
    -- this API is only available from neovim 0.7+
    if not vim.api.nvim_create_user_command then
        return vim.api.notify_once('Abbreviations are only available in neovim 0.7+. Please update.')
    end

    local options = { nargs = 0 }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_create_user_command(from, to, options)
end

function M.border(hl_name)
    return {
        { '╭', hl_name },
        { '─', hl_name },
        { '╮', hl_name },
        { '│', hl_name },
        { '╯', hl_name },
        { '─', hl_name },
        { '╰', hl_name },
        { '│', hl_name },
    }
end

function M.load_module(mod)
    local ok, res = pcall(require, mod)

    if not ok then
        vim.notify_once(string.format('Failed to load module %s | %s', mod, res))
    end
end

return M
