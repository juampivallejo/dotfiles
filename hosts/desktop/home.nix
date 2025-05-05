{ lib, config, pkgs, username, ... }:
let
  homeDirectory = "/home/${username}";
  overlays = import ../../overlays { inherit config; };
in {
  targets.genericLinux.enable = true;

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
      QT_XCB_GL_INTEGRATION = "none"; # kde-connect
      NIXPKGS_ALLOW_UNFREE = "1";
      GOPATH = "${homeDirectory}/.local/share/go";
      GOMODCACHE = "${homeDirectory}/.cache/go/pkg/mod";
    };

    sessionPath = [ "$HOME/.local/bin" ];
  };

  desktopApps = {
    enable = true;
    ghostty = true;
  };
  enableHyprland = true;
  enableFastFetch = true;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = overlays;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
