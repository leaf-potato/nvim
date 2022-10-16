local toggleterm = require("toggleterm")

toggleterm.setup({
    open_mapping = [[<c-\>]],
    -- 终端宽度设置
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
        end
    end,
    -- 插入模式下启动
    start_in_insert = true
})