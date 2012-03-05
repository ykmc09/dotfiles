syntax on
filetype off

"新しい行のインデントを現在行と同じにする
"set autoindent

"バックアップファイル、スワップファイルを作るディレクトリ
set backupdir=~/.tmp
set directory=~/.tmp

"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
set list
"listで表示される文字のフォーマットを指定する
set listchars=tab:>\ ,extends:<
"行番号を表示する
set number

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'ZenCoding.vim'

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
