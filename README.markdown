A wonderful vim configuration 
==========================

Features:
--------------------------

It seems like I'm reinventing wheels. Have a look at https://github.com/spf13/spf13-vim 
Plugins that I've selected resembles those of spf13-vim. But I have configure them to fit my taste.

TODO

Requirements:
--------------------------

For taglist, you need ctags, which is included in cscope package in most linux distributions.
For clangcomplete, you may need libclang. (Haven't tried yet)
For other things, I think at least python is needed, while usually it should be installed by default.


Install:
--------------------------

clone the repo to your ~/.vim 
	
	git clone https://github.com/yyk/vimsettings-2013.git ~/.vim

write just one line into your ~/.vimrc containing:

	echo "source ~/.vim/vimrc" >> ~/.vimrc

run ~/.vim/updateall.sh to update submodules from other external git repos.

	sh ~/.vim/updateall.sh 

you may also copy the content of ~/.vim/bashrcforvim to ~/.bashrc in case you need those features.
	
	echo "source ~/.vim/bashrcforvim" >> ~/.bashrc
