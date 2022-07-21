require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 16
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.33
        end
    end,
    open_mapping = '<C-`>'
})
