{ pkgs, lib, config, inputs, pkgs-unstable, ... }: {

  options = { desktopApps.enable = lib.mkEnableOption "Enables desktop Apps"; };

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      slack # Messaging
      pkgs-unstable.thunderbird # Email client
      obsidian # Notes
      calibre # e-Books
      insomnia # Postman alternative
      stremio # streaming
      pkgs-unstable.dbeaver-bin # DB connections
      mongodb-compass # Mongo Explorer
      vlc
      spotify
      discord
      postman # mostly for reptrak
      inputs.zen-browser.packages."${system}".specific
    ];
  };
}
