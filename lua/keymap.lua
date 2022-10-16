--------------------------------
-- 插件快捷键
--------------------------------
local pluginKeys = {}

local opts = {
    noremap = true,
    silent = true,
}
local map = vim.api.nvim_set_keymap

-- nvim-tree
map("n", "<leader>fl", ":NvimTreeToggle<CR>", opts)

-- 列表快捷键
pluginKeys.nvimTreeList = {
    -- 进入下一级
    { key = { "]" }, action = "cd" },
    -- 进入上一级
    { key = { "[" }, action = "dir_up" },
}

return pluginKeys
