local colors = {
    bg = '#2e3440',
    fg = '#d8dee9',
    yellow = '#ebcb8b',
    cyan = '#81a1c1',
    darkblue = '#5e81ac',
    green = '#a3be8c',
    orange = '#d08770',
    violet = '#b48ead',
    magenta = '#b48ead',
    blue = '#81a1c1',
    red = '#bf616a',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local time = function()
    return os.date('%a %d %b %Y @ %H:%M')
end

local set_statusline_refresh = function()
    local redraw = function()
        vim.api.nvim_command('redrawtabline')
    end

    if _G.Tabline_timer == nil then
        _G.Tabline_timer = vim.loop.new_timer()
    else
        _G.Tabline_timer:stop()
    end
    -- never timeout, repeat every 5000ms
    _G.Tabline_timer:start(0, 5000, vim.schedule_wrap(redraw))
end

local config = {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        theme = 'onedark',
        globalstatus = true,
        disabled_filetypes = { 'nvimtree' },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- these will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

-- left hand side
ins_left({
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.green, gui = 'bold' },
})

ins_left({
    'filetype',
    icons_enabled = true,
    color = { fg = colors.blue, gui = 'bold' },
})

ins_left({
    -- lsp server name
    function()
        local msg = 'None'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = '',
    color = { fg = colors.blue, gui = 'bold' },
})

ins_left({
    'location',
    color = { fg = colors.orange, gui = 'bold' },
})

ins_left({
    'progress',
    color = { fg = colors.orange, gui = 'bold' },
})

-- right hand side
ins_right({
    'branch',
    icon = '',
    color = { fg = colors.violet, gui = 'bold' },
})

ins_right({
    'diff',
    symbols = { added = ' ', modified = '柳', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})

ins_right({
    time,
    color = { colors.darkblue, gui = 'bold' },
})

require('lualine').setup(config)
set_statusline_refresh()
