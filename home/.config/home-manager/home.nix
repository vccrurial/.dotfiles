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
    wget2 uv bat ripgrep ripgrep-all fd dust gtrash
    gitFull rclone btop htop comma
    yazi exiftool file poppler_utils ffmpeg ffmpegthumbnailer p7zip atool unar unrar-wrapper
    wl-clipboard xdg-terminal-exec-mkhl
    fish zoxide any-nix-shell
    emacs-pgtk helix
    nerd-fonts.jetbrains-mono
  ];
}
