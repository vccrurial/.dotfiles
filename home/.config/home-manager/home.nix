# nix-channel --add https://nixos.org/channels/nixos-unstable pkgs
{ pkgs, ... }:
{
  news.display = "silent";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";  
  home.shell.enableFishIntegration = true;
  home.shell.enableBashIntegration = true;
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    keepassxc wget2 uv bat ripgrep ripgrep-all fd dust gtrash
    gitFull rclone btop htop rqbit comma vtm
    yazi exiftool file poppler_utils ffmpeg ffmpegthumbnailer p7zip atool unar unrar-wrapper
    xclip wl-clipboard xdg-terminal-exec-mkhl warpd
    fish zoxide any-nix-shell
    emacs30-gtk3 helix vscode
    nerd-fonts.jetbrains-mono
  ];
}
