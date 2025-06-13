{ pkgs, lib, config, inputs, ... }: {

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      slack # Messaging
      # thunderbird # Email client
      obsidian # Notes
      calibre # e-Books
      # insomnia # Postman alternative
      # stremio # streaming
      # google-chrome
      # dbeaver-bin # DB connections
      # mongodb-compass-overlay
      vlc
      spotify
      discord
      # postman # mostly for work
      # windsurf # AI editor
      # quickemu # QEMU VM easy
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
