#!/usr/bin/env bash

scripts_dir=`dirname ${BASH_SOURCE}`;
cd "${scripts_dir}";

#git pull origin master;

function doIt() {
    for file in ~/.{bash_profile,gitconfig}; do
        if [ -f "$file" ]; then
            mv ${file} ${file}.bak;
        fi
    done;
    ln -s ${scripts_dir}/gitconfig ~/.gitconfig;
    echo "source ${scripts_dir}/bash_profile" > ~/.bash_profile;
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
fi;
unset doIt;
