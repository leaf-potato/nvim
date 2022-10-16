local autocmd = vim.api.nvim_create_autocmd

-- nvim-tree 最后1个窗口自动关闭
autocmd("BufEnter", {
    nested = true,
    callback = function()
        local wins_count = #vim.api.nvim_list_wins()
        local tree_exist = vim.api.nvim_buf_get_name(0):match("NvimTree_");
        if wins_count == 1 and tree_exist ~= nil then
            vim.cmd("quit")
        end
    end
})
