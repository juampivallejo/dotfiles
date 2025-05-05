{ pkgs, ... }:

{
  # Basic user setup
  users.users.jp = {
    home = "/Users/jp";
    shell = pkgs.zsh;
  };
  system.stateVersion = 6;

  # Enable useful macOS options
  programs.zsh.enable = true;

  # Optional: set your hostname
  # networking.hostName = "JPs-iMac-Pro";
  homebrew = {
    enable = true;

    onActivation = { autoUpdate = true; };
    casks = [ "ghostty" "warp" "firefox" ];
    brews = [ ];
  };

  # Optional: fonts (for Nerd Fonts)
  environment.systemPackages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
