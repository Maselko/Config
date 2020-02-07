"           _
"    _   __(_)___ ___  __________
"   | | / / / __ `__ \/ ___/ ___/
"  _| |/ / / / / / / / /  / /__
" (_)___/_/_/ /_/ /_/_/   \___/
"
" Sebastian Tamon Haściłowicz
"

    let mapleader = " "

" Plugins to blnd them all  ===========================================
    call plug#begin('~/.vim/plugged')
    Plug 'acarapetis/vim-colors-github'
    Plug 'altercation/solarized'
    Plug 'arcticicestudio/nord-vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'LukeSmithxyz/vimling'
    Plug 'tpope/vim-vividchalk'
    Plug 'vimwiki/vimwiki'
    call plug#end()


"= Basic Stuff ========================================================
    set nocompatible
    syntax on
    set guifont=InconsolataLGC\ 11    " font on gui
    set linespace=0                   " font space size
    set encoding=utf-8                " encoding
    set number relativenumber         " sets numbers on left
    set shiftwidth=4
    set autoindent
    set smartindent
    set smarttab
    set softtabstop=4
    if has("gui_running")             " colorschemes
       colo Chester                   " gui colour
    else
       colo vividchalk                " terminal colour
    endif


"= Mappings ===========================================================
" To keep my hands still healthy
    noremap! ` <Esc>l
    noremap ; :
    map ;; ;

" Make easy access to ~/.vimrc
    nnoremap <C-^> :e $MYVIMRC<CR>

" The autocompletion stuff (Insert Mode only)
    imap <C-j> <C-n>
    imap <C-k> <C-p>

" Shortcuts split navigation (Normal Mode only)
    nmap <C-h> <C-w>h
    nmap <C-j> <C-w>j
    nmap <C-k> <C-w>k
    nmap <C-l> <C-w>l

" Resize split screen (Visual Mode only)
    vmap <C-h> <C-w><
    vmap <C-j> <C-w>+
    vmap <C-k> <C-w>-
    vmap <C-l> <C-w>>

" Run Vimcomp to compile the program
    map <leader>c :w! \| !./Tools/vim/vimcom.sh <c-r><CR>

" File manager opener
    nnoremap <leader>e :Explore ~/<CR>
    map <leader>fm :Vexplore ~/<CR>

" Toggle 72 character line by pressing <leader> + l
    nnoremap <leader>l :execute "set colorcolumn=" . (&colorcolumn == "" ? "73" : "")<CR>

" Spell-check set to <leader> + o, 'o' for 'Orthography'
    map <leader>oe :setlocal spell! spelllang=en_gb<CR>
    map <leader>op :setlocal spell! spelllang=pl<CR>

" Paste from clipboard
    map <leader>p "+p

" Check file shell check
    map <leader>sh :!clear && shellcheck %<CR>

" Terminal for <leader> + t
    map <leader>t :ter<CR>

" Copy to clipboard
    vnoremap <leader>y "+y


"= Other Settings =====================================================
" To prevent moving cursor when Esc is pressed
    inoremap <silent> <Esc> <C-O>:stopinsert<CR>

" Autocomplitation
    set wildmode=longest,list,full

" Disable autocommenting
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim default
    set splitbelow splitright

" Automatically deletes all traling whitespaces
    au BufWritePre * %s/\s\+$//e

" Automatically change color for texts
    au BufReadPost,BufNewFile *.md,*.txt,*.tex,*.bib colo TeXdarktheme

" automatically do :so ~/.vimrc
    autocmd BufWritePost .vimrc source $MYVIMRC

" Fuzzy file finder(ish)
    set path+=**

" file browsing
    filetype plugin on
    let g:netrw_banner=0        " disable annoying banner
    let g:netrw_browse_split=0  " open in prior window
    let g:netrw_altv=1          " open splits to the right
    let g:netrw_liststyle=3     " tree view
    let g:netrw_list_hide=netrw_gitignore#Hide()
    let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


"= STATUSLINE =========================================================
" :h mode() to see all modes
    let g:currentmode={
	\ 'n'      : 'NORMAL ',
	\ 'no'     : 'N·O•PE ',
	\ 'v'      : 'VISUAL ',
	\ 'V'      : 'V·LINE ',
	\ "\<C-V>" : 'V·BLOCK ',
	\ 's'      : 'SELECT ',
	\ 'S'      : 'S·LINE ',
	\ "\<C-S>" : 'S·BLOCK ',
	\ 'i'      : 'INSERT ',
	\ 'R'      : 'REPLACE ',
	\ 'Rv'     : 'V·REPLACE ',
	\ 'c'      : 'COMMAND ',
	\ 'cv'     : 'VIM EX ',
	\ 'ce'     : '  EX   ',
	\ 'r'      : 'PROMPT ',
	\ 'rm'     : ' MORE  ',
	\ 'r?'     : 'CONFIRM ',
	\ '!'      : 'SH•CMD ',
	\ 't'      : 'TERMINAL '
	\}

" Automatically change the statusline color depending on mode
    function! ChangeStatuslineColor()
	if (mode() =~# '\v(n|no)')
	    exe 'hi! StatusLine ctermbg=015 ctermfg=002 guibg=green4 guifg=white'
	elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·BLOCK ')
	    exe 'hi! StatusLine ctermbg=000 ctermfg=015 guibg=white guifg=black'
	elseif (mode() =~# 'i')
	    exe 'hi! StatusLine ctermbg=015 ctermfg=006 guibg=DeepSkyBlue guifg=white'
	elseif (mode() =~# 'R')
	    exe 'hi! StatusLine ctermbg=015 ctermfg=009 guibg=red2 guifg=white'
	elseif (get(g:currentmode, mode(), '') ==# 't')
	    exe 'hi! StatusLine ctermbg=015 ctermfg=000 guibg=black guifg=white'
	else
	    exe 'hi! StatusLine ctermbg=015 ctermfg=003 guibg=goldenrod guifg=white'
	endif
	return ''
    endfunction

" Find out current buffer's size and output it
    function! FileSize()
      let bytes = getfsize(expand('%:p'))
      if (bytes >= 1024)
	let kbytes = bytes / 1024
      endif
      if (exists('kbytes') && kbytes >= 1000)
	let mbytes = kbytes / 1000
      endif
      if bytes <= 0
	return '0'
      endif
      if (exists('mbytes'))
	return mbytes . 'MB '
      elseif (exists('kbytes'))
	return kbytes . 'KB '
      else
	return bytes . 'B '
      endif
    endfunction
    set laststatus=2
    set statusline=
    set statusline+=%{ChangeStatuslineColor()}     " Changing the statusline colour
    set statusline+=%0*\ %{g:currentmode[mode()]}  " Current mode
    set statusline+=%#Visual#           " colour
    set statusline+=%{&paste?'\ PASTE\ ':''}
    set statusline+=%{&spell?'\ SPELL\ ':''}
    set statusline+=%#Cursor#           " colour
    set statusline+=%R                  " readonly flag
    set statusline+=%{&modified?'+':''} " modified [+] flag
    set statusline+=%#CursorIM#         " colour
    set statusline+=%#CursorLine#       " colour
    set statusline+=\ %t\               " short file name
    set statusline+=%=                  " right align
    set statusline+=%#CursorLine#       " colour
    set statusline+=\ %Y\               " file type
    set statusline+=%-3(%{FileSize()}%) "file size
    set statusline+=%#Cursor#           " colour
    set statusline+=\ %3l:%-2c\         " line + column
    set statusline+=%#CursorIM#         " colour
    set statusline+=\ %3p%%\            " percentage
    set noshowmode

" statusline on and off
    map <leader>bs :so ~/.vimrc<CR>
    map <leader>bh :set laststatus=0 \| set showmode \| set ruler<CR>


"= Pluginstuff ========================================================
" Goyo plugin to make text readable
    map <leader>r :Goyo \| set linebreak<CR>

" Vimwiki
    let g:vimwiki_list = [{'path': '~/Tools/vim/vimwiki/', 'syntax': 'markdown'}]
    au FileType vimwiki setlocal shiftwidth=3 tabstop=3 noexpandtab
