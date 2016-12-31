if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/kawana/.vimrc', '/home/kawana/dein.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/kawana/.vim/dein'
let g:dein#_runtime_path = '/home/kawana/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/home/kawana/.vim/dein/.cache/.vimrc'
let &runtimepath = '/home/kawana/.vim/dein/repos/github.com/Shougo/dein.vim,/home/kawana/.vim,/var/lib/vim/addons,/home/kawana/.vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,/home/kawana/.vim/after,/home/kawana/.vim/dein/.cache/.vimrc/.dein/after'
filetype off
 autocmd FileType python setlocal completeopt-=preview
