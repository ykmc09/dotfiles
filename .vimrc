syntax on
filetype on

"バックアップファイル、スワップファイルを作るディレクトリ
set backupdir=~/.tmp
set directory=~/.tmp


"---------------------------------------------------------------------------
" 検索挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" インクリメンタルサーチを行う
set incsearch
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan


"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブ幅
set tabstop=2
set shiftwidth=2
" タブをスペースに展開しない
set noexpandtab
" 自動インデント
set autoindent
" バックスペースでインデントや改行を削除できるように
set backspace=indent,eol,start
" 括弧入力時に対応する括弧を表示
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM


"---------------------------------------------------------------------------
" 画面表示の設定:
"
" 行番号を表示
set number
" ルーラー表示
set ruler
" タブや改行を表示
set list
set listchars=tab:▸.,trail:_,eol:↲,extends:»
" 全角スペースを表示
highlight zenkakuspace ctermbg=7
call matchadd("zenkakuspace", '\%u3000')
" 行折り返し
set wrap
" 常にステータス行を表示
set laststatus=2
" コマンドラインの高さ
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title


"---------------------------------------------------------------------------
" キー、カーソル設定
"
" キーバインド変更
imap <C-j> <C-[>
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" カーソルを行頭、行末で止まらないようにする
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


"---------------------------------------------------------------------------
" プラグイン
"
" Vundle 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'ZenCoding.vim'
Bundle 'surround.vim'
Bundle 'quickrun.vim'
Bundle 'neocomplcache'
Bundle 'vim-coffee-script'

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" TABでオートコンプリート
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

