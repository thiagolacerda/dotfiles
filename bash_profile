# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the shell dotfiles, and then some:
scripts_path=`dirname ${BASH_SOURCE[0]}`
for file in ${scripts_path}/{bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Update windows size on command
shopt -s checkwinsize

# Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

shopt -s expand_aliases

# Extended pattern
shopt -s extglob

# No empty completion
shopt -s no_empty_cmd_completion

# if we have fzf installed
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi;

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
fi;
