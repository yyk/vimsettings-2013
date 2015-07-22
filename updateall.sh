#!/bin/sh 
#git submodule add repo_url local_path
cd ~/.vim
git submodule init 
git submodule update
git pull 
git submodule foreach 'git pull origin master'
