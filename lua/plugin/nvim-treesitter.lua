local nvim_treesitter_configs = require("nvim-treesitter.configs")

nvim_treesitter_configs.setup({
    -- 需要安装语言的parse
    ensure_installed = {"cpp"},
    -- 不同步安装
    sync_install = false,

    highlight = {
        -- 打开高亮功能
        enable = true,

        -- 需要关闭高亮的语言
        disable = {},
        additional_vim_regex_highlighting = false,
    }
})
