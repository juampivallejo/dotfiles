{ pkgs, username, ... }:
let homeDirectory = "/home/${username}";
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

  desktopApps.enable = true;
  hyprland.enable = true;
  neofetch.enable = true;
  kitty.transparency.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Required to install Obsidian
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
