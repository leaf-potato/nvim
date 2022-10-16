local nvim_tree = require("nvim-tree")
local list_key = require("keymap").nvimTreeList

nvim_tree.setup({
    -- 完全禁止内置netrw
    disable_netrw = true,
    sort_by = "case_sensitive",
    git = {
        -- git图标开关
        enable = false,
    },
    filters = {
        -- 不显示隐藏文件
        dotfiles = true
    },
    view = {
        -- 窗口宽度
        width = 40,
        -- 显示在右边, 也可以left
        side = "right",
        adaptive_size = false,
        mappings = {
            list = list_key
        },
        -- 不显示行数
        number = false,
        relativenumber = false
    },
    actions = {
        open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭 tree
            quit_on_open = false,
        }
    },
    renderer = {
        group_empty = true
    }
})
