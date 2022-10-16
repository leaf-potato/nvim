" 设置vim不兼容vi模式
set nocompatible

" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自动显示相对行号
set number
set relativenumber
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler

" 高亮显示当前行/列
" set cursorline
" set cursorcolumn

" 高亮显示搜索结果
set hlsearch
" 高亮部分匹配搜索结果
set is
" 解决插入模式下delete/backspce键失效问题
set backspace=2

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
"set foldmethod=syntax

" 启动 vim 时关闭折叠代码
set nofoldenable

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" ============= 窗口跳转快捷键 =========================
"
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" ============= vim-plug插件配置信息 ====================
"
" vim-plug 管理的插件列表必须位于 plug#begin() 和 plug#end() 之间
call plug#begin('~/.config/nvim/plugged')

" lsp客户端实现代码提示
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 代码高亮
Plug 'airblade/vim-gitgutter'
" Plug 'simrat39/symbols-outline.nvim'

Plug 'tpope/vim-fugitive'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" markdown插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" 主题插件
Plug 'sainnhe/gruvbox-material'

" terminal插件
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

call plug#end()

" ============= coc-nvim插件配置信息 ====================
"
" coc插件(启动nvim时会自动检测并下载)
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-vimlsp',
    \ 'coc-clangd',
    \ 'coc-webview',
    \ 'coc-sumneko-lua']

"medium 高亮光标所在的词
autocmd CursorHold * silent call CocActionAsync('highlight')


let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material 

" 加载lua配置
:lua require("lua.lua")

" CocList配置
" 过滤当前光标所在的word
nnoremap <silent> <space>w  :exe 'CocList -I --normal --number-select --auto-preview  --input='.expand('<cword>').' words'<CR>
" nnoremap <silent> <space>w  :exe 'CocList -I --normal --auto-preview location --input='.expand('<cword>').' words'<CR>

" 过滤选中的关键词
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
function! s:GrepFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocList grep '.word
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>