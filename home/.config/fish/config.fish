any-nix-shell fish --info-right | source
zoxide init fish | source

set fish_greeting
set -gx PATH "$HOME/bin:$HOME/.local/bin:$PATH"
set -gx EDITOR hx
set -gx VISUAL "$EDITOR"
set -gx MANWIDTH 92
set -gx BROWSER firefox
set -gx TERMINAL wezterm
set -gx LESSHISTFILE -
set check_distro (awk -F= '/^NAME=/ { print $2 }' /etc/os-release)

abbr --add -- cp 'cp -v'
abbr --add -- dcp 'sudo cp -v'
abbr --add -- dmkd 'sudo mkdir -pv'
abbr --add -- dmv 'sudo mv -v'
abbr --add -- g git
abbr --add -- md 'mkdir -pv'
abbr --add -- mv 'mv -v'
abbr --add -- hreb 'home-manager switch'
abbr --add -- rm 'gtrash put'
abbr --add -- hms 'cp -rsf $HOME/.dotfiles/home/. ~'
abbr --add -- se sudoedit
abbr --add -- sys systemctl

if test "$check_distro" = NixOS
    abbr --add -- reb 'sudo nixos-rebuild switch --flake $HOME/dotfiles/nixos/. --impure'
end

function postexec_test --on-event fish_postexec
    echo
end

function yy
    set -l tmp (mktemp -t "yazi-cwd.XXXXX")
    command yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# https://github.com/fish-shell/fish-shell/issues/5394
if status is-interactive
    function ssh-no-password
        eval (ssh-agent -c)
        ssh-add ~/.ssh/id_rsa
    end
end
