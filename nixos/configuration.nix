# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./auto-upgrade.nix
      ./gnome.nix
      ./hyprland.nix
      ./i18n.nix
      ./sound.nix
      ./bluetooth.nix
      ./theme.nix
    ];

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Setting nvidia driver for Hyprland
    videoDrivers = [ "nvidia" ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.juampi = {
    isNormalUser = true;
    description = "juampi";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    # -- Basic Packages --
    vim
    wget
    gcc
    gnumake
    unzip

    # -- Development --
    kitty
    tmux
    neovim
    git
    docker
    python3Full
    python3Packages.pip
    pyenv
    go
    cargo
    lazygit
    nodePackages.cspell
    insomnia

    nodePackages.pyright
    nodePackages.vscode-json-languageserver
    lua-language-server
    stylua # Lua formatter
    ruff # Python formatter
    isort # Python Sort
    nil # Nix LSP
    nixpkgs-fmt # Nix format
    prettierd # Formatter

    # Software
    appimage-run # Run programs shipped as AppImage e.g. Obsidian
    slack

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # -- Programs Config --

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Zsh
  programs.zsh = {
    # Your zsh config
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "docker" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;

  # Docker
  # users.users.juampi.extraGroups = [ "docker" ];  # Already set above
  users.extraGroups.docker.members = [ "juampi" ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      # Use docker without root
      enable = true;
      setSocketVariable = true;
    };
  };

  # Obsidian
  # This didn't work but the idea is that it would donwload the Obsidian AppImage automatically, then I need to add it to the desktop
  # appimageTools.wrapType2 = { # or wrapType1
  #   name = "Obsidian";
  #   src = fetchurl {
  #     url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.8/Obsidian-1.5.8.AppImage";
  #     # hash = "sha256-OqTitCeZ6xmWbqYTXp8sDrmVgTNjPZNW0hzUPW++mq4=";
  #   };
  #   extraPkgs = pkgs: with pkgs; [ ];
  # }

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # -- Custom Nix settings --
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
