set -gx EDITOR nvim
set -gx MANPAGER "sh -c 'col -bx | bat --theme \"Monokai Extended\" -l man -p'"

set PATH /opt/homebrew/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude ".git"'

fzf --fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias gl="GITHUB_TOKEN=(security find-generic-password -s hub -a sergei -w) gh"
    alias e=nvim
    alias jj="yarn jenkins-job"
    # alias s="kitty +kitten ssh"

    # abbr -a e nvim
    # abbr -a jj 'yarn jenkins-job'
    abbr -a s 'kitty +kitten ssh'
    abbr -a dotdot --regex '^\\.\\.+$' --function multicd
    abbr -a jira-issue --regex '[A-Z]{3,5}-[0-9]{1,6}' --function openjira

    abbr -a gam 'git commit --amend --reuse-message=HEAD'
    abbr -a gp 'git pull'
    abbr -a gpy 'git pull && yarn install'
    abbr -a gpp 'git pull && pnpm install'
    abbr -a gpf 'git push --force-with-lease'
    abbr -a gr 'git fetch origin develop:develop && git rebase develop'
    abbr -a gra 'git rebase --abort'
    abbr -a grc 'git rebase --continue'
    abbr -a gs 'git status --short'
    abbr -a gco 'git checkout'
    abbr -a gcd 'git checkout develop'
    abbr -a gcob --set-cursor 'git checkout -b feature/TAP-%'
    abbr -a gcoc 'git coc'
    abbr -a gcm --set-cursor 'git commit -m "%"'
    abbr -a gsc 'git sco'
end

nvm use v20.14.0 --silent

# pnpm
set -gx PNPM_HOME "/Users/sergei/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
