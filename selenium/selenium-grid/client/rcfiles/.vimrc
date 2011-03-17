".vimrc
"
set nocompatible
syntax on
filetype plugin indent on

set tabstop=2     "indentation
set shiftwidth=2  "indent/outdent
set expandtab     "convert tabs to spaces
set smarttab      "insert blanks according to shiftwidth
set shiftround    "indent/outdent to nearest tabstop
set autoindent    "preserve current indent on new lines

set backspace=indent,eol,start "make backspaces delete sensibly

set matchpairs+=<:> "allow % to bounce between angles too
set history=50
set statusline=\ %F%m%r%h%w\ (%{&ff})\ {%Y}\ [Line:\ %l/%L,\ Col:\ %v]\ [%p%%]
set laststatus=2  "always display statusline
set showmode      "show message when in Insert, Replace or Visual mode
set showcmd       "show command line in status line

" Search
set incsearch     "enable incremental search
set hlsearch      "highlight search results
set wrapscan      "search commands wrap around end of line
set ignorecase    "case insensitive searching

" Open file to cursor position of the last edited location
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif
