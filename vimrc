colorscheme vividchalk

filetype plugin indent on

syntax on

set nocompatible
set number
set ts=2
set sw=2
set modelines=3 " scan 3 lines for vim opts

set laststatus=2 " always show statusline even on sigle window
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

set expandtab
set incsearch   " show search results as I type.
set ignorecase  " ignore case on searches...
set smartcase   " ...but if I start with uppercase, obey it.
set ruler       " show ruler with filename & cursor position
set hlsearch    " search is highlighted, nohlsearch do disable
set cursorline  " set a highlight on the line where the cursor is
set showcmd     " show partial command entered
set visualbell  " no beeps when I make a mistakes
set background=dark " need bright colors since terminal background is black
set hidden      " don't bug me with modified buffers when switching
set switchbuf=useopen " if buffer is opened focus on it
set wrap        " wrap by default

" proper behavior of DEL, BS, CTLR-w; otherwise you can't BS after an ESC
set backspace=eol,start,indent


nnoremap <leader>w :%s/\s\+$//<bar>normal <C-o><cr>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
" nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

" CSE means Clear Screen and Execute, use it by
" mapping (depending of the project) to a test runner command
" map <leader>r CSE('rspec', '--color')<cr>
function! CSE(runthis, ...)
  :wa
  exec ':!clear && tput cup 1000 0;' . a:runthis . ' ' . join(a:000, ' ')
endfunction
