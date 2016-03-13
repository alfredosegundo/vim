colorscheme vividchalk

execute pathogen#infect()

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

:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" map for open vimrc and autosource
map <leader>vimrc :tabe ~/.vim/vimrc<cr>
autocmd bufwritepost .vimrc source $VIMRC

" nerdtree mappings
"

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" vim-go mappings
"
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>in <Plug>(go-install)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>e <Plug>(go-rename)
