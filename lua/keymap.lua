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
map("n", "<leader>fl", ":NvimTreeFindFileToggle<CR>", opts)

-- toggleterm
map("t", "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})
map("t", "<leader>lw", "<Cmd> wincmd l<CR>", {noremap = true, silent = true})
map("t", "<leader>hw", "<Cmd> wincmd h<CR>", {noremap = true, silent = true})
map("t", "<leader>jw", "<Cmd> wincmd j<CR>", {noremap = true, silent = true})
map("t", "<leader>kw", "<Cmd> wincmd k<CR>", {noremap = true, silent = true})

-- 列表快捷键
pluginKeys.nvimTreeList = {
    -- 进入下一级
    { key = { "]" }, action = "cd" },
    -- 进入上一级
    { key = { "[" }, action = "dir_up" },
}

return pluginKeys
