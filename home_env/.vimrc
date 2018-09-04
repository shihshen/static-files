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
    set nobackup                " Disable backup file.
    scriptencoding utf-8

" }


" Formatting {

    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 2 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every 2 columns
    set softtabstop=4               " Let backspace delete indent
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
                let g:NERDTreeDirArrows=0
                let g:NERDTreeDirArrowExpandable = ">"
                let g:NERDTreeDirArrowCollapsible = "<"
        endif

    " General Programming
        if count(g:bundle_groups, 'programming')
            Plug 'junegunn/fzf', { 'do': './install --bin' }
                nnoremap <C-P> :FZF<CR>
                if executable('ag')
                  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
                endif
            Plug 'mhinz/vim-grepper'
                if executable('ag')
                    nnoremap <SPACE>/ :GrepperAg 
                else
                    nnoremap <SPACE>/ :Grepper 
                endif
            Plug 'scrooloose/syntastic'
                au BufRead,BufNewFile *.json set filetype=json
                let g:syntastic_javascript_checkers = ['flow']
                let g:syntastic_mode_map = {
                  \ "mode": "active",
                  \ "passive_filetypes": ["python"]
                  \}
            "Plug 'Chiel92/vim-autoformat' " python support required
            Plug 'maksimr/vim-jsbeautify', { 'do': 'git submodule update --init --recursive'}
                autocmd FileType javascript noremap <buffer>  <c-i> :call JsBeautify()<cr>
                " for json
                autocmd FileType json noremap <buffer> <c-i> :call JsonBeautify()<cr>
                " for html
                autocmd FileType html noremap <buffer> <c-i> :call HtmlBeautify()<cr>
                " for css or scss
                autocmd FileType css noremap <buffer> <c-i> :call CSSBeautify()<cr>
            Plug 'ervandew/supertab'
            Plug 'will133/vim-dirdiff'
        endif

    " Misc
        if count(g:bundle_groups, 'misc')
        endif
    
    " Initialize plugin system
    call plug#end()

" }
