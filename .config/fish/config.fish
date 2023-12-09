if status is-interactive
    # Commands to run in interactive sessions can go here
    if command -q starship 
        starship init fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/composer3/.ghcup/bin $PATH # ghcup-env

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
