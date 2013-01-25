"ABOUT Original settings
"set backspace=2   "这个太诡异了！，自己编译安装的7.2就需要这句
set autoread	"文件从外部发生变化时自动读入
set modeline
set autowrite	"切换buffer时自动写入
set fileencodings=utf-8,chinese "打开文件时先尝试utf-8，否则尝试所有中文编码，有这么一句基本上就不会遇到乱码问题了
set wildmenu "输入命令时按tab能在状态栏显示匹配
"set cursorline "在当前行下面划一条线
"以下两行能够实现只在活跃窗口当前行下面划线
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set ignorecase "查找时忽略大小写
set tabstop=4
set shiftwidth=4
set number "显示行号
colorscheme desert "我修改后的desert主题

"set foldmethod=indent
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

"about taglist
let Tlist_Inc_Winwidth=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_WinWidth=30
let Tlist_Use_Right_Window=1
let Tlist_Use_SingleClick=0
"let tlist_php_settings = 'php;c:class;i:interfaces;d:const;f:function'

"about minibuf
let g:miniBufExplMapWindowNavVim=1 "Ctrl-<hjkl> to move to window
let g:miniBufExplTabWrap=1 "make tabs show complete (no broken on two lines)
let g:miniBufExplUseSingleClick=1 "single click to open a tab

"about some key maps	
"map <F3> :Ex<CR>
map <F4> :Tlist<CR>
map OS :Tlist<CR>
"minibuf
"map O1;5D :bp<CR>	
"map <C-Left> :bp<CR>
"map <C-H> :bp<CR>
"map O1;5C :bn<CR>
"map <C-Right> :bn<CR>
"map <C-L> :bn<CR>
map <F3> :NERDTreeToggle<CR>
map OR :NERDTreeToggle<CR>
" make it like eclipse
map <C-W> :wq<CR>
"map <C-D> dd
"imap <C-D> <C-O>dd
"imap <C-U> <C-O>u
"imap <C-R> <C-O><C-R>
" navigate using ctrl+hljk in insert mode
"imap <C-H> <C-O>h
"imap <C-L> <C-O>l
"imap <C-J> <C-O>j
"imap <C-K> <C-O>k
"imap <C-N> <C-O>j<C-O>OH
"imap <C-P> <C-O>k<C-O>OF
" make it like windows
map <C-A> ggvG<END> "全选
map <C-C> "+y "复制到系统剪切板
map  <C-s> :w<CR> "保存
imap <C-S> <C-O>:w<CR>
" ctrl+s是terminal的一个feature，会锁住terminal，为达到以上效果需要先执行
" stty stop ^@
" make it like visual studio
"map <C-F7> :wa<CR>:make<CR>
map <F9> :call EnhancedCommentify('yes', 'guess')<CR>

"""""""""""""""""""""""""""""""""""""
" 	about better use of cscope 	   "
"""""""""""""""""""""""""""""""""""""
"from :help cscope 如果文件夹下有cscope.out则自动加载
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

"map <C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
map <C-[> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map <C-F8> :!cscope -ubqRC<CR>:cs kill 0<CR>:cs add cscope.out<CR>
	"重建cscope.out，断开原有cscope连接并建立新的连接
	"-u 无条件重建，假设所有文件都发生了改变
	"-b build the cross-reference only
	"-q make it faster
	"-R recurse subdirs
	"-C ignore letter case when searching

"有趣的用法
":X 设置密码
":set key=(空) 取消密码

" for vimgdb
"if version > 701
"	set previewheight=1
"	run macros/gdb_mappings.vim
"	set asm=0
"	set gdbprg=gdb
"endif

" for python completion
python << EOF
import os
import sys
import vim
for p in sys.path:
	if os.path.isdir(p):
		vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

"completion
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType ada set omnifunc=adacomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType phtml set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby set omnifunc=rubycomplete#Completeruby
autocmd FileType sql set omnifunc=sqlcomplete#Completesql

"my snippets
autocmd FileType java Snippet ,o System.out.println(<{}>);<CR><{}>
autocmd FileType python Snippet forr for <{}> in range(<{}>):<CR><{}>
autocmd FileType python Snippet pyutf8 #!/usr/bin/env python<CR># -*- coding:utf8 -*-<CR><CR><{}>
autocmd FileType python Snippet utf8 # -*- coding:utf8 -*-<CR><CR><{}>

autocmd FileType cpp Snippet pojcpp #include <iostream><CR>using namespace std;<CR><CR>int main()<CR>{<CR><{}><CR><BS>return 0;<CR>}<CR>
autocmd FileType c Snippet pojc #include "stdio.h"<CR><CR>int main()<CR>{<CR><{}><CR><BS>return 0;<CR>}<CR>
" for django
autocmd FileType htmldjango Snippet block {% block <{}> %}<CR><CR>{% endblock %}
" for php and phtml
autocmd FileType php Snippet foreach foreach (<{}>) {<CR><CR>}
autocmd FileType phtml Snippet foreach <?php foreach (<{}>):?><CR><?php endforeach;?>
autocmd FileType php Snippet getpost $this->_request->getPost<{}>
autocmd FileType php Snippet getquery $this->_request->getQuery<{}>
autocmd FileType phtml Snippet if <?php if (<{}>):?><CR><?php endif;?>
autocmd FileType php Snippet if if (<{}>) {<CR><CR>}
"run and debug python program
autocmd FileType python map <F5> :w<CR>:!python %<CR>
autocmd FileType python map <F6> :w<CR>:!pdb %<CR>

"remove trailing whitespaces when saving
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ''
autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.phtml :%s/\s\+$//e


"autocmd FileType c :set foldmethod=syntax
autocmd FileType python setlocal expandtab smarttab shiftwidth=4 softtabstop=4 smartindent
autocmd FileType html,phtml setlocal expandtab smarttab shiftwidth=4 softtabstop=4 smartindent


let g:sql_type_default = 'mysql'

"NERDTree 
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc$', '\cscope.*$']

let loaded_matchit=1

function! PhpParseExecute()
    " Parse and execute current php file
    setlocal makeprg=php -l

    " Set shellpipe
    setlocal shellpipe=>

    " Use error format for parsing PHP error output
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    make %
    clist
endfunction

map <F6> :call PhpParseExecute()<CR>
imap <F6> <ESC>:call PhpParseExecute()<CR>

"if filereadable($VIRTUAL_ENV . '/.vimrc')
"	source $VIRTUAL_ENV/.vimrc
"endif
