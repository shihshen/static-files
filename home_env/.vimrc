" Environment {

    " Basics {
        set nocompatible        " Must be first line
    " }

" }

" General {

    set background=dark         " Assume a dark background
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set re=2                    " Abandon old regular expression engine
    set noswapfile              " Disable swap file.
    set nobackup                " Disable backup file.
    set hidden
    scriptencoding utf-8

" }


" Formatting {

    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 2 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every 2 columns
    set softtabstop=2               " Let backspace delete indent
    "set mouse=v                     " Enable mouse for copying. However, mouse may not be supported.
    set ignorecase                  " Smart search
    set smartcase
    set incsearch

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
                set noshowmode
            Plug 'scrooloose/nerdtree'
                map <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>
                map <leader>e :NERDTreeFind<CR>
                nmap <leader>nt :NERDTreeFind<CR>
                let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
                let g:NERDTreeMouseMode=2
                let g:NERDTreeShowHidden=1
                let g:NERDTreeQuitOnOpen=1
                let g:NERDTreeDirArrowExpandable = ">"
                let g:NERDTreeDirArrowCollapsible = "<"
        endif

    " General Programming
        if count(g:bundle_groups, 'programming')
            Plug 'ctrlpvim/ctrlp.vim'
            if executable('rg')
              set grepprg=rg\ --color=never
              let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
              let g:ctrlp_use_caching = 0
            endif
            let g:ctrlp_working_path_mode = 'ra'
            let g:ctrlp_switch_buffer = 'ET'
            let g:ctrlp_prompt_mappings = { 
                  \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
                  \ 'AcceptSelection("t")': ['<cr>']
                  \ }
            Plug 'mhinz/vim-grepper'
                if executable('ag')
                    nnoremap <SPACE>/ :GrepperAg 
                else
                    nnoremap <SPACE>/ :Grepper 
                endif
            " Autocomplete: tabnine (high memory consumption), deoplete (unstable), youcompleteme (complicated installation) have their own issues for now.
            Plug 'ervandew/supertab'
            Plug 'will133/vim-dirdiff'
        endif

    " Misc
        if count(g:bundle_groups, 'misc')
            " Auto format/indent
            Plug 'prettier/vim-prettier', { 'do': 'npm install' }
            let g:prettier#autoformat = 0 " :Prettier to format/indent the file
        endif
    
    " Initialize plugin system
    call plug#end()

" }
