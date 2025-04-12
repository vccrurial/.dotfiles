{ pkgs, lib, ... }:
{
  imports = [ /etc/nixos/hardware-configuration.nix ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "preempt=full" "quiet" "splash" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ intel-media-driver intel-vaapi-driver ];
  networking.hostName = "chminux";
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  time.timeZone = "Europe/Moscow";
  system.stateVersion = "25.05";
  zramSwap.enable = true;
  programs.fish.enable = true;
  users.users.vcc = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  environment.systemPackages = with pkgs; [
    libreoffice-qt6-fresh chromium firefox  wezterm
    vlc qbittorrent telegram-desktop lsb-release
  ];
  security.rtkit.enable = true;
  services.thermald.enable = true;
  services.dbus.implementation = "broker";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.keyd.enable = true;
  services.keyd.keyboards.default.extraConfig = builtins.readFile ./keyd.conf;
}
