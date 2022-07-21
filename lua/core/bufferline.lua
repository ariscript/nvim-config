-- adapted from https://github.com/noib3/nvim-cokeline#author-miversen33

local get_hex = require('cokeline/utils').get_hex

local space = { text = ' ' }
local inactive_bg = get_hex('Normal', 'bg')
local bg_color = get_hex('ColorColumn', 'bg')
local text_fg = get_hex('Normal', 'fg')

local active_bg = '#1a212e'
local error_fg = '#c95157'
local warning_fg = '#e08926'

require('cokeline').setup({
    default_hl = {
        bg = function(buf)
            if buf.is_focused then
                return active_bg
            end
        end,
    },
    components = {
        {
            text = function(buf)
                local text = ''
                if buf.index > 1 then text = ' ' end
                if buf.is_focused or buf.is_first then
                    text = text .. ''
                end
                return text
            end,
            fg = function(buf)
                if buf.is_focused then
                    return active_bg
                elseif buf.is_first then
                    return inactive_bg
                end
            end,
            bg = function(buf)
                if buf.is_focused then
                    if buf.is_first then
                        return bg_color
                    else
                        return inactive_bg
                    end
                elseif buf.is_first then
                    return bg_color
                end
            end,
        },
        {
            text = function(buf)
                local status = ''
                if buf.is_readonly then
                    status = '➖'
                elseif buf.is_modified then
                    status = ''
                end
                return status
            end,
        },
        {
            text = function(buf)
                return ' ' .. buf.devicon.icon
            end,
            fg = function(buf)
                return buf.devicon.color
            end,
        },
        {
            text = function(buf)
                return buf.unique_prefix .. buf.filename
            end,
            fg = function(buf)
                if buf.diagnostics.errors > 0 then
                    return error_fg
                elseif buf.diagnostics.warnings > 0 then
                    return warning_fg
                else
                    return text_fg
                end
            end,
            style = function(buf)
                local text_style = 'NONE'
                if buf.is_focused then
                    text_style = 'bold'
                end
                if buf.diagnostics.errors > 0 then
                    if text_style ~= 'NONE' then
                        text_style = text_style .. ',underline'
                    else
                        text_style = 'underline'
                    end
                end
                return text_style
            end,
        },
        space,
        {
            text = function(buf)
                if buf.diagnostics.errors > 0 then
                    return '' .. buf.diagnostics.errors
                elseif buf.diagnostics.warnings > 0 then
                    return '' .. buf.diagnostics.warnings
                else
                    return ''
                end
            end,
            fg = function(buf)
                if buf.diagnostics.errors > 0 then
                    return error_fg
                elseif buf.diagnostics.warnings > 0 then
                    return warning_fg
                end
            end,
            style = function(buf)
                return 'bold'
            end,
        },
        {
            text = '',
            delete_buffer_on_left_click = true
        },
        {
            text = function(buf)
                if buf.is_focused or buf.is_last then
                    return ''
                else
                    return ' '
                end
            end,
            fg = function(buf)
                if buf.is_focused then
                    return active_bg
                elseif buf.is_last then
                    return inactive_bg
                else
                    return bg_color
                end
            end,
            bg = function(buf)
                if buf.is_focused then
                    if buf.is_last then
                        return bg_color
                    else
                        return inactive_bg
                    end
                elseif buf.is_last then
                    return bg_color
                end
            end
        }
    }
})
