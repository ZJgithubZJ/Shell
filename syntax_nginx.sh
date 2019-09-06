#!/bin/bash
mkdir -p /root/.vim/syntax
mv nginx.vim /root/.vim/syntax
for file in `find / -name filetype.vim`
do
	echo "au BufRead,BufNewFile /usr/local/nginx/* set ft=nginx" >> ${file} || exit 1
done
