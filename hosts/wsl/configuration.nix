# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "juampi";
  wsl.docker-desktop.enable = true;
  networking.hostName = "wsl";

  environment.systemPackages = with pkgs; [
    # -- Basic Packages --
    vim
    git
    wget
    gcc
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  time.hardwareClockInLocalTime = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
