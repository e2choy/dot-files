let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let NERDTreeShowHidden=1
let loaded_matchit = 1
let g:loaded_matchparen=1
" set t_Co=256
" nvim -u NONE
let g:airline_theme='kalisi'

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
  "Plug 'junegunn/fzf'
  " }}}

  " Neomake {{{
  Plug 'benekastah/neomake'
  let g:neomake_verbose = 0
  augroup Neomake
    au!
    au! BufWritePost * Neomake
  augroup END
  " }}}
 
  " YouCompleteMe {{{
  "  if g:has_python
  "    Plug 'Valloric/YouCompleteMe'
  "  endif
  " }}}

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
  "map <f11> :mode<cr>
  nnoremap <f5> :wa<bar>silent Neomake!<bar>cwindow<cr>
  nnoremap <f8> :cn<cr>
  nnoremap <f7> :cp<cr>
  "map <c-,> :CtrlP<cr>
  
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
  au VimEnter * NERDTree
  " au VimResized * :mode
  " }}}
  " REPL integration {{{
  "nnoremap <silent> <f6> :REPLSendLine<cr>
  "vnoremap <silent> <f6> :REPLSendSelection<cr>
  " }}}
endfunction

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
"set incsearch " highlight matches while typing search pattern
"set hlsearch " highlight previous search matches
set wrap " automatically wrap text when 'textwidth' is reached
set foldmethod=indent " by default, fold using indentation
set nofoldenable " don't fold by default
set foldlevel=0 " if fold everything if 'foldenable' is set
set foldnestmax=10 " maximum fold depth
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
