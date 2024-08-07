{ pkgs, lib, config, ... }: {

  options = { desktopApps.enable = lib.mkEnableOption "Enables desktop Apps"; };

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      slack # Messaging
      obsidian # Notes
      calibre # e-Books
      insomnia # Postman alternative
      stremio # streaming
      dbeaver-bin # DB connections
      vlc
      spotify
      discord
    ];
  };
}
