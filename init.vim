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

Plug 'scrooloose/nerdtree' " 文件目录显示
Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp客户端实现代码提示
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 代码高亮
Plug 'tomasiser/vim-code-dark'
Plug 'airblade/vim-gitgutter'
" Plug 'simrat39/symbols-outline.nvim'

Plug 'tpope/vim-fugitive'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" markdown插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" ============= nerdtree插件配置信息 ====================

" 使用 NERDTree 插件查看工程文件, 设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=40 " 设置NERDTree子窗口宽度
let NERDTreeWinPos="right" " 设置NERDTree子窗口位置
let NERDTreeShowHidden=1 " 显示隐藏文件
let NERDTreeMinimalUI=1 " NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeAutoDeleteBuffer=1 " 删除文件时自动删除文件对应 buffer
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " 最后一个窗口自动关闭

" ============= coc-nvim插件配置信息 ====================
"
" coc插件(启动nvim时会自动检测并下载)
let g:coc_global_extensions = [
    \ 'coc-vimlsp',
    \ 'coc-cmake',
    \ 'coc-clangd',
    \ 'coc-json']
" 不保存缓存区可以跳转
set hidden

" 关闭备份, 不关闭代码提示可能会出现问题
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" 合并行号
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" 使用tab滚动补全信息
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 使用ctrl+o手动触发补全信息
if has('nvim')
  inoremap <silent><expr> <c-o> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" 使用回车确认补全信息
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 在代码错误中进行跳转
nmap <silent> <Leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>= <Plug>(coc-diagnostic-next)

" 函数调用和定义间跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use <Leader>h to show documentation in preview window.
nnoremap <silent> <Leader>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 高亮光标所在的词
autocmd CursorHold * silent call CocActionAsync('highlight')

" colorscheme codedark
set background=light

" ============= nvim-treesitter插件配置信息 ====================
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
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
    },
}
EOF

" ============= nvim-tree插件配置信息 ====================
"

" ============= markdown-preview.nvim插件配置信息 ====================
"
" let g:mkdp_open_to_the_world = 1
" let g:mkdp_open_ip = '182.61.1.107'
" let g:mkdp_port = '8888'
" let g:mkdp_echo_preview_url = 1
