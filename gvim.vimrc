let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let NERDTreeShowHidden=1
let loaded_matchit = 1
let g:loaded_matchparen=1
" set t_Co=256
" nvim -u NONE
let g:airline_theme='kalisi'
let g:ycm_confirm_extra_conf=0
let g:ctrlp_switch_buffer = 'Et'
let g:neomake_open_list = 2
let g:ctrlp_open_multiple_files = 'ij'
let g:ycm_show_diagnostics_ui = 0
let g:ctrlp_map = '<c-p>'
"let g:ycm_autoclose_preview_window_after_insertion = 1
set wildignore+=*.o,*.d
set clipboard=unnamed
set autoindent
set cindent
set hidden
set nohlsearch

" Plugins {{{
function! VimrcLoadPlugins()
  " Install vim-plug if not available {{{
  if !isdirectory(g:vim_plug_dir)
    call mkdir(g:vim_plug_dir, 'p')
  endif
  if !isdirectory(g:vim_plug_dir.'/autoload')
    execute '!git clone git://github.com/junegunn/vim-plug '
          \ shellescape(g:vim_plug_dir.'/autoload', 1)
  endif
  " }}}

  call plug#begin()
  " Misc {{{
  Plug 'freeo/vim-kalisi'
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'scrooloose/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  "Plug 'junegunn/fzf'
  " }}}

  " Neomake {{{
  Plug 'benekastah/neomake'
  "let g:neomake_verbose = 0
  "augroup Neomake
  "  au!
  "  au! BufWritePost * Neomake
  "augroup END
  " }}}
 
  " YouCompleteMe plugin
  "YouCompleteMe {{{
   if g:has_python
     Plug 'Valloric/YouCompleteMe'
   endif
  "}}}

  call plug#end()
endfunction

function! VimrcLoadMappings()
  " Misc {{{
  let g:mapleader = ","
  " execute the current line or selection
  nnoremap <silent> <leader>t "ryy:@r<cr>
  vnoremap <silent> <leader>t "rygv:@r<cr>
  " toggle spell on/off
  nnoremap <silent> <leader>s :set spell!<cr>
  " edit vimrc
  nnoremap <leader>e :e $MYVIMRC<cr>
  " clear search highlight with ,c
  nnoremap <silent> <leader>c :noh<cr>
  " search/replace the word under the cursor
  nnoremap <leader>z :let @z = expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
  " help
  inoremap <f1> <esc>:help 
  nnoremap <f1> <esc>:help 
  vnoremap <f1> <esc>:help 
  map <silent> <f12> :mode<cr>
  map <f11> :mode<cr>
  "nnoremap <f5> :wa<bar>Neomake!<bar>cwindow<cr>
  "nnoremap <f5> :wa<bar>silent Neomake!<bar>cwindow<cr>
  "nnoremap <f5> :wa<bar>Neomake!<bar>cwindow<cr>
  "nnoremap <f5> :wa<bar>Neomake!<cr>
  nnoremap <f5> :wa<bar>:!tmux new -d "./a.out"<cr>
  nnoremap <f6> :cfirst<cr>
  nnoremap <f7> :cp<cr>
  nnoremap <f8> :cn<cr>
  nnoremap <C-S-B> :wa<bar>Neomake!<cr>
  nnoremap <C-S-E> :copen<bar>:cfirst<cr>
  
  " move text up/down
  "nnoremap <silent> <c-j> :m .+1<cr>==
  "nnoremap <silent> <c-k> :m .-2<cr>==
  "vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
  "vnoremap <silent> <c-k> :m '<-2<cr>gv=gv
  " }}}
  " Editing {{{
  nnoremap <leader>gf :e <cfile><cr>
  " }}}
  " Quickfix/location list {{{
  " augroup quick_loc_list
  "   au! BufWinEnter quickfix nnoremap <silent> <buffer>
  "         \	q :cclose<cr>:lclose<cr>
  " augroup END
  nnoremap <silent> <leader>q :botright copen 10<cr>
  nnoremap <silent> <leader>l :botright lopen 10<cr>
  " }}}
  " Window/buffer navigation and manipulation {{{
  nnoremap <leader>e :e $MYVIMRC<cr>
  " zoom with <c-w>z in any mode
  nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
  inoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>a
  vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv
  if has('nvim') && exists(':tnoremap')
    tnoremap <c-w>j <c-\><c-n><c-w>j
    tnoremap <c-w>k <c-\><c-n><c-w>k
    tnoremap <c-w>h <c-\><c-n><c-w>h
    tnoremap <c-w>l <c-\><c-n><c-w>l
    tnoremap <pageup> <c-\><c-n><pageup>
    tnoremap <pagedown> <c-\><c-n><pagedown>
    tnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>
  endif
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  "autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
  set autochdir "working directory to current file
  "autocmd VimEnter * if &modifiable | NERDTree % | wincmd p | endif
  autocmd VimEnter * if argc() | NERDTree % | wincmd p | endif


endfunction

fun! SetMkfile()
  let filemk = "Makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf

command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10

if !exists('g:vimrc_initialized')
  let g:is_windows = has('win32') || has('win64')
  " Little hack to set the $MYVIMRC from the $VIMINIT in the case it was used to 
  " initialize vim.
  if empty($MYVIMRC)
    let $MYVIMRC = substitute($VIMINIT, "^source ", "", "g")
  endif
  " Extract the directory from $MYVIMRC
  let g:rc_dir = strpart($MYVIMRC, 0, strridx($MYVIMRC, (g:is_windows ? '\' : '/')))
  let $RCDIR = g:rc_dir
  let g:plugins_dir = g:rc_dir.'/plugged'
  let g:vim_plug_dir = g:plugins_dir.'/vim-plug'
  let &runtimepath = g:rc_dir.','.g:vim_plug_dir.','.$VIMRUNTIME
  let g:has_python = has('python')

  call VimrcLoadPlugins()
  let g:vimrc_initialized = 1
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

if has('nvim')
  augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    au WinEnter term://* startinsert
  augroup END
endif
call VimrcLoadMappings()
colorscheme kalisi

" set nolazyredraw
set background=dark
set ruler
set number
set expandtab " expand tabs into spaces
set softtabstop=2 " number of spaces used with tab/bs
set tabstop=2 " display tabs with the width of two spaces
set shiftwidth=2 " indent with two spaces 
set ignorecase " ignore case when searching
set smartcase " disable 'ignorecase' if search pattern has uppercase characters
set incsearch " highlight matches while typing search pattern
"set hlsearch " highlight previous search matches
set wrap " automatically wrap text when 'textwidth' is reached
"set foldmethod=indent " by default, fold using indentation
set foldmethod=syntax " by default, fold using indentation
set nofoldenable " don't fold by default
set foldlevel=0 " if fold everything if 'foldenable' is set
set foldnestmax=10 " maximum fold depth


autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "disable autocomment
"autocmd CompleteDone * pclose
"map <A-p> :cp<cr>
"map <C-p> :cp<cr>
"map <C-n> :cn<cr>
"function s:Cursor_Moved()
set cul
"  let cur_pos = winline()
"if g:last_pos == 0
"  set cul
"  let g:last_pos = cur_pos
"  return
"endif
"let diff = g:last_pos - cur_pos
"if diff > 1 || diff < -1
"  set cul
"else
"  set nocul
"endif
"let g:last_pos = cur_pos
"endfunction
"autocmd CursorMoved,CursorMovedI * call s:Cursor_Moved()
"let g:last_pos = 0

"Window Only"
set backspace=indent,eol,start
"colorscheme desert
cd C:\Users\EHREN\Desktop
set filetype=cpp
map <C-t> :tabe<cr>
map <C-Tab> gt
map <C-S-Tab> gT
autocmd BufEnter * if &filetype == "" | setlocal ft=cpp | endif

