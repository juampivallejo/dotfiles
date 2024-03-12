{ pkgs, username, ... }:
let
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ./utils.nix
    ./neofetch.nix
    ./home-folders.nix
    ./packages.nix
    ./kitty.nix
  ];

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
      QT_XCB_GL_INTEGRATION = "none"; # kde-connect
      NIXPKGS_ALLOW_UNFREE = "1";
      GOPATH = "${homeDirectory}/.local/share/go";
      GOMODCACHE = "${homeDirectory}/.cache/go/pkg/mod";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  gtk.gtk3.bookmarks = [
    "file://${homeDirectory}/Documents"
    "file://${homeDirectory}/Music"
    "file://${homeDirectory}/Pictures"
    "file://${homeDirectory}/Videos"
    "file://${homeDirectory}/Downloads"
    "file://${homeDirectory}/Desktop"
    "file://${homeDirectory}/Projects"
    "file://${homeDirectory}/Vault"
    "file://${homeDirectory}/.config Config"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "21.11";
}
