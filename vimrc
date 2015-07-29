call pathogen#infect()
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'ultisnips')

" map CTRL-E to end-of-line (insert mode)
imap <C-e> <esc>$i<right>
" map CTRL-A to beginning-of-line (insert mode)
imap <C-a> <esc>0i

"ABOUT Original settings
set nocompatible  
set backspace=2   "我的osx就是需要这个，不然backspace无效
set autoread	"文件从外部发生变化时自动读入
set modeline
set autowrite	"切换buffer时自动写入
set fileencodings=utf-8,chinese "打开文件时先尝试utf-8，否则尝试所有中文编码，有这么一句基本上就不会遇到乱码问题了
set wildmenu "输入命令时按tab能在状态栏显示匹配
"set cursorline "在当前行下面划一条线
"以下两行能够实现只在活跃窗口当前行下面划线
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
set history=10000
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

nnoremap j gj
nnoremap k gk

" For when you forget to sudo.. Really Write the file. Really good.
cmap w!! w !sudo tee % >/dev/null

if has('statusline')
	set laststatus=2
	set statusline=%<%f\ " Filename
	set statusline+=%w%h%m%r " Options
	set statusline+=%{fugitive#statusline()} " Git Hotness
	set statusline+=\ [%{&ff}/%Y] " Filetype
	set statusline+=\ [%{getcwd()}] " Current dir
	set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

let g:sql_type_default = 'mysql'

set ignorecase "查找时忽略大小写
set smartcase
set tabstop=2
set shiftwidth=2
set expandtab
set number "显示行号

syntax enable
set background=dark
colorscheme solarized
colorscheme desert 

set foldmethod=indent
set foldmethod=marker
set hlsearch "高亮搜索字
set incsearch "增量搜索
set showcmd "在底行显示正在输入的命令
set mouse=a
set scrolloff=1 "滚动时始终保证光标上下至少有一行

filetype on "自动检测文件类型
filetype plugin on
filetype indent on
syntax on

"set completeopt=menu,preview
set completeopt=menu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
nmap <F4> :TagbarToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" minibuf
let g:miniBufExplMapWindowNavVim=1 "Ctrl-<hjkl> to move to window
let g:miniBufExplTabWrap=1 "make tabs show complete (no broken on two lines)
let g:miniBufExplUseSingleClick=1 "single click to open a tab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key maps	
map <F3> :NERDTreeToggle<CR>
map OR :NERDTreeToggle<CR>
map <F9> :call EnhancedCommentify('yes', 'guess')<CR>
"map <C-W> :wq<CR>
map <C-J> <C-W>j<C-W> 
map <C-K> <C-W>k<C-W> 
map <C-L> <C-W>l<C-W> 
map <C-H> <C-W>h<C-W> 

" navigate using ctrl+hljk in insert mode
" imap <C-H> <C-O>h
" imap <C-L> <C-O>l
" imap <C-J> <C-O>j
" imap <C-K> <C-O>k
" select all
" map <C-A> ggvG<END>
" ctrl+shift+c to copy to system paste
map  "+y
" save
" you need stty stop ^@ in .bashrc
map  <C-s> :w<CR>
map  :w<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope
" I need to autobuild the cscope database
if has("cscope")
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif filereadable("Kconfig")
		silent !echo "Building cscope database for the kernel, it takes a long time, have a cup of coffee. Ctrl-c to bypass or touch cscope.out to fool me."
		silent !cscope -bkRC
		cs add cscope.out
	elseif filereadable("CMakeLists.txt") || filereadable("Makefile") || filereadable("configure")
		silent !echo "Building cscope database, it may take a long time, ctrl-c to bypass."
		silent !cscope -bRC
		cs add cscope.out
	endif
	set csverb
endif

map <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
map  :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"map  :vimgrep <C-R>=expand("<cword>")<CR> **/**.c **/**.h **/**.cpp <CR>
map  :Ack -i <C-R>=expand("<cword>")<CR> <CR>
map <F8> :!cscope -bRC<CR>:cs kill 0<CR>:cs add cscope.out<CR>
	"重建cscope.out，断开原有cscope连接并建立新的连接
	"-u 无条件重建，假设所有文件都发生了改变
	"-b build the cross-reference only
	"-q make it faster
	"-R recurse subdirs
	"-C ignore letter case when searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" for python completion
"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" completion methods 
"autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType ada set omnifunc=adacomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType phtml set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType ruby set omnifunc=rubycomplete#Completeruby
"autocmd FileType sql set omnifunc=sqlcomplete#Completesql
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove trailing whitespaces when saving
" autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,gcl,borg,jsont autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"autocmd BufWritePre *.py normal m`:%s/\s\+$//e ''
"autocmd BufWritePre *.php :%s/\s\+$//e
"autocmd BufWritePre *.phtml :%s/\s\+$//e
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab width 
autocmd FileType python setlocal expandtab smarttab shiftwidth=2 softtabstop=2 smartindent
autocmd FileType html,phtml setlocal expandtab smarttab shiftwidth=2 softtabstop=2 smartindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NERDTree 
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc$', '\cscope.*$', '\.o$', '\~$']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache 
"follow the setting examples from official site 
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 2
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

let g:neocomplcache_enable_auto_select = 0

" Plugin key-mappings.
" inoremap <expr><C-l>     neocomplcache#complete_common_string()
let g:neocomplcache_enable_auto_select=0

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-e>  neocomplcache#complete_common_string()

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" fix conflict with clangcomplete
let g:neocomplcache_force_overwrite_completefunc = 1
let g:clang_complete_auto = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippets
" barely used so comment out
" autocmd FileType BUILD Snippet sv xxx
"autocmd FileType java Snippet ,o System.out.println(<{}>);<CR><{}>
"autocmd FileType python Snippet forr for <{}> in range(<{}>):<CR><{}>
"autocmd FileType python Snippet pyutf8 #!/usr/bin/env python<CR># -*- coding:utf8 -*-<CR><CR><{}>
"autocmd FileType python Snippet utf8 # -*- coding:utf8 -*-<CR><CR><{}>
"
"autocmd FileType cpp Snippet pojcpp #include <iostream><CR>using namespace std;<CR><CR>int main()<CR>{<CR><{}><CR><BS>return 0;<CR>}<CR>
"autocmd FileType c Snippet pojc #include "stdio.h"<CR><CR>int main()<CR>{<CR><{}><CR><BS>return 0;<CR>}<CR>
" for django
"autocmd FileType htmldjango Snippet block {% block <{}> %}<CR><CR>{% endblock %}
" for php and phtml
"autocmd FileType php Snippet foreach foreach (<{}>) {<CR><CR>}
"autocmd FileType phtml Snippet foreach <?php foreach (<{}>):?><CR><?php endforeach;?>
"autocmd FileType php Snippet getpost $this->_request->getPost<{}>
"autocmd FileType php Snippet getquery $this->_request->getQuery<{}>
"autocmd FileType phtml Snippet if <?php if (<{}>):?><CR><?php endif;?>
"autocmd FileType php Snippet if if (<{}>) {<CR><CR>}
"run and debug python program
"autocmd FileType python map <F5> :w<CR>:!python %<CR>
"autocmd FileType python map <F6> :w<CR>:!pdb %<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("persistent_undo")
	set undodir=$HOME/.undotree
	set undofile
	set undolevels=1000
	set undoreload=10000
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StripTrailingWhitespace()
	" To disable the stripping of whitespace, add the following to your
	" .vimrc.local file:
	" let g:spf13_keep_trailing_whitespace = 1
	if !exists('g:spf13_keep_trailing_whitespace')
		" Preparation: save last search, and cursor position.
		let _s=@/
		let l = line(".")
		let c = col(".")
		" do the business:
		%s/\s\+$//e
		" clean up: restore previous search history, and cursor position
		let @/=_s
		call cursor(l, c)
	endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" powerline
"set term=mac-ansi
"let g:Powerline_symbols = 'fancy'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" solarized
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""
" for eclim and neocomplcache 
"
let g:EclimCompletionMethod = 'omnifunc'

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.java = '\k\.\k*'

hi SpecialKey ctermfg=1 guifg=gray

autocmd FileType proto set colorcolumn=80
" unclear where textwidth for txt is set, overriding it here.
autocmd FileType text set textwidth=0
autocmd FileType gitcommit set textwidth=0

let g:LargeFile=10

" ultisnip
let g:UltiSnipsExpandTrigger="<tab>"
