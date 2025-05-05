{ pkgs, username, ... }:
let homeDirectory = "/Users/${username}";
in {
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  home = {
    inherit username homeDirectory;

    sessionVariables = {
      EDITOR = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  isDarwin = true;
  desktopApps = {
    enable = false;
    ghostty = false;
  };
  enableHyprland = false;
  enableFastFetch = true;

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
