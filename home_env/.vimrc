" Environment {

    " Basics {
        set nocompatible        " Must be first line
    " }

" }

" General {

    set background=dark         " Assume a dark background
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set noswapfile              " Disable swap file.
    scriptencoding utf-8

" }


" Formatting {

    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 2 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every 2 columns
    set softtabstop=2               " Let backspace delete indent
    set pastetoggle=<F6>            " pastetoggle (sane indentation on pastes)
    set mouse=                      " Enable mouse
    set ignorecase                  " Smart search
    set smartcase

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following let g:leader='\'
    if !exists('g:leader')
        let mapleader = ','
    else
        let mapleader=g:leader
    endif

    " Easier creating tabs
    map <leader>t :tabnew<CR>

    " Easier moving in windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add let g:no_easyWindows = 1
    if !exists('g:no_easyWindows')
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h
        if has('nvim')
          " Hack to get C-h working in NeoVim
          nmap <BS> <C-W>h
        endif
    endif

    " Easier moving in tabs
    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following line
    "   let g:no_fastTabs = 1
    if !exists('g:no_fastTabs')
        map <S-E> gT
        map <S-R> gt
    endif

    " Continuous indentation
    vnoremap < <gv
    vnoremap > >gv

    " Map <leader>fr to find and replace all words under the cursor in this file with 's'
    nmap <leader>fr :%s/\<<C-r><C-w>\>/s/gc

" }

" Plugins {
    " Get vim-plug first at https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    " list only the plugin groups you will use
    if !exists('g:bundle_groups')
        let g:bundle_groups=['general', 'programming', 'misc']
    endif

    " General
        if count(g:bundle_groups, 'general')
            Plug 'altercation/vim-colors-solarized'
            Plug 'bling/vim-airline'
            Plug 'scrooloose/nerdtree'
            Plug 'jistr/vim-nerdtree-tabs'
                map <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>
                map <leader>e :NERDTreeFind<CR>
                nmap <leader>nt :NERDTreeFind<CR>
                let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
                let NERDTreeChDirMode=0
                let NERDTreeMouseMode=2
                let NERDTreeShowHidden=1
                let NERDTreeKeepTreeInNewTab=1
                let g:nerdtree_tabs_open_on_gui_startup=0
                let g:NERDTreeDirArrows=0
        endif

    " General Programming
        if count(g:bundle_groups, 'programming')
            Plug 'Shougo/denite.nvim', { 'do': 'pip3 install neovim' }
                nnoremap <C-p> :Denite file_rec<CR>
                nnoremap <SPACE>/ :Denite -no-quit grep<CR>
            Plug 'mhinz/vim-grepper'
            Plug 'scrooloose/syntastic'
                au BufRead,BufNewFile *.json set filetype=json
                let g:syntastic_javascript_checkers = ['flow']
                let g:syntastic_mode_map = {
                  \ "mode": "active",
                  \ "passive_filetypes": ["python"]
                  \}
            Plug 'Chiel92/vim-autoformat'
                noremap <C-i> :Autoformat<cr>
            Plug 'ervandew/supertab'
            Plug 'will133/vim-dirdiff'
        endif

    " Misc
        if count(g:bundle_groups, 'misc')
        endif
    
    " Initialize plugin system
    call plug#end()

    " Customize plugins with vim-plug
    call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
    call denite#custom#option('_', 'highlight_matched_range', 'None')
    call denite#custom#option('_', 'highlight_matched_char', 'None')
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<C-u>', '<denite:scroll_page_backwards>', 'noremap')
    call denite#custom#map('insert', '<C-d>', '<denite:scroll_page_forwards>', 'noremap')
    call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy'])
    call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
    if executable('pt')
        call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '-l', ''])
        call denite#custom#var('grep', 'command', ['pt'])
        call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern-opt', [])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final-opts', [''])
    elseif executable('ag')
      call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
      call denite#custom#var('grep', 'command', ['ag'])
      call denite#custom#var('grep', 'default_opts', ['-i'])
      call denite#custom#var('grep', 'recursive_opts', [])
      call denite#custom#var('grep', 'pattern_opt', [])
      call denite#custom#var('grep', 'separator', ['--'])
      call denite#custom#var('grep', 'final_opts', [])
    endif
" }
