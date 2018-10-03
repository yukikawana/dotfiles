if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END
" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
let s:colors_dir = s:cache_home . '/colors'
  call system('mkdir '. shellescape(s:colors_dir))
  call system('wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -P '. shellescape(s:colors_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}} 
syntax on
set number
colorscheme molokai 
set t_Co=256
"IndentGuidesEnable
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 1
set autoindent
set smartindent

" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
let g:neocomplete#force_omni_input_patterns = {} 
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" }}}
"
" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clang
let g:clang_auto = 0
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

function! s:get_latest_clang(search_path)
let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
let l:clang_exec_list = []
for l:file in l:filelist
if l:file =~ '^.*clang-\d\.\d$'
call add(l:clang_exec_list, l:file)
endif

if len(l:clang_exec_list)
return reverse(l:clang_exec_list)[0]
else
return 'clang'
endif
endfunction
                                                                                                             
                                                                                                             function! s:get_latest_clang_format(search_path)
let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
let l:clang_exec_list = []
for l:file in l:filelist
if l:file =~ '^.*clang-format-\d\.\d$'
call add(l:clang_exec_list, l:file)
endif
endfor
if len(l:clang_exec_list)
return reverse(l:clang_exec_list)[0]
else
return 'clang-format'
endif
endfunction

let g:clang_exec = s:get_latest_clang('/usr/bin')
"let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'


"let g:clang_format_auto = 1
"let g:clang_format_style = 'Google'


inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>

set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch           
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
set nowritebackup
set nobackup
set noswapfile

set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" 入力モード中に素早くjjと入力した場合はESCとみなす
"inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %
"set mouse=a
"set ttymouse=xterm2

set ts=4 sw=4 et
"set expandtab
"set tabstop=2
"set shiftwidth=2
:inoremap <silent> jj  <ESC>`^
