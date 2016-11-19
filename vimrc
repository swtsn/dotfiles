"""""
" Vundle setup
"""""
set nocompatible       " no compatibility with vi
filetype off           " recognize syntax by file extension
au! FileType python setl nosmartindent    " Don't use smartindent for python files
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'nvie/vim-flake8'
Plugin 'elzr/vim-json'
call vundle#end()            " required
filetype plugin indent on    " required



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      .vimrc -- the way it ought to be                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on              " syntax highlighting
hi clear search        " do not highlight all search matches

set ai
set si

set background=light  " background light, so foreground not bold
set backspace=2       " allow <BS> to go past last insert
set gdefault          " assume :s uses /g
set ignorecase        " ignore case in search patterns
set smartcase         " searches are case-sensitive if caps used
set incsearch         " immediately highlight search matches
set noerrorbells      " no beeps on errors
set nomodeline        " prevent others from overriding this .vimrc
set number            " display line numbers
set ruler             " display row, column and % of document
set showcmd           " show partial commands in the status line
set showmatch         " show matching () {} etc.
set showmode          " show current mode
set expandtab         " expand tabs with spaces
set tabstop=2         " <Tab> move four characters
set shiftwidth=2      " >> and << shift 2 spaces
set nowrap            " don't soft wrap
"set textwidth=89      " hard wrap at 89 characters
set modeline          " check for a modeline
set softtabstop=2     " see spaces as tabs
set scrolloff=5       " start scrolling when cursor is N lines from edge
set laststatus=2      " always show the bottom status bar
set tags=~/.python-tags;~/dev     " set tag location

" custom status bar setup
set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P

noremap <Ins> 2<C-Y>   " <Ins> defaults like i
noremap <Del> 2<C-E>   " <Del> defaults like x

" Highlights long lines
highlight OverLength ctermfg=red
match OverLength /\%161v.\+/

" Use the space key to open and close code folds
:vnoremap <space> zf<CR>
:nnoremap <space> zd<CR>

" Because we don't like our line numbers sometimes...
:nnoremap <C-N><C-N> :set invnumber<CR> 

" ...and all the cool kids need to paste.
:nnoremap <C-p><C-p> :set invpaste<CR>

" wrap inverter
:nnoremap <C-w><C-w> :set invwrap<CR>

" Tabs can be fun too!
:nnoremap ,. :tabnew<CR>
:nnoremap ., :tabclose<CR>

" And this is how pros navigate splits and tabs.
:nnoremap ,q :tabp<CR>
:nnoremap ,e :tabn<CR>
:nnoremap ,w <c-w><Up><CR>
:nnoremap ,s <c-w><Down><CR>
:nnoremap ,a <c-w><Left><CR>
:nnoremap ,d <c-w><Right><CR>

" Show and hide extra whitespace
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:nnoremap ,z :match ExtraWhitespace /\s\+$/<CR>
:nnoremap ,x :match<CR>

" Call 'svn blame' on the current file and grab the output for the current line
" plus the surrounding context. Display the result via echo and redraw the
" screen after input.
function SvnBlame(linesOfContext)
   let pos = line(".")
   let text = system("svn blame " . expand("%:p"))
   let tempName = tempname()

   exec "redir! > " . tempName
   silent echon text
   redir END
   execute "botr " . (a:linesOfContext * 2 + 1) . "split " . tempName
   exec pos
   norm zz
   redraw!
endfunction
