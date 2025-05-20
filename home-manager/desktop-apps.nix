{ pkgs, lib, config, inputs, ... }: {

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      slack # Messaging
      thunderbird # Email client
      obsidian # Notes
      calibre # e-Books
      insomnia # Postman alternative
      # stremio # streaming
      dbeaver-bin # DB connections
      mongodb-compass-overlay
      google-chrome
      vlc
      spotify
      discord
      postman # mostly for work
      windsurf # AI editor
      inputs.zen-browser.packages."${system}".default
      # quickemu # QEMU VM easy
    ];
  };
}
