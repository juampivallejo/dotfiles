{ pkgs, lib, config, inputs, ... }: {

  options = {
    desktopApps = {
      enable = lib.mkEnableOption "Enables desktop Apps";
      kitty = lib.mkEnableOption "Enables kitty terminal";
      ghostty = lib.mkEnableOption "Enables ghostty terminal";
    };
  };

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      slack # Messaging
      thunderbird # Email client
      obsidian # Notes
      calibre # e-Books
      insomnia # Postman alternative
      stremio # streaming
      dbeaver-bin # DB connections
      mongodb-compass-overlay
      google-chrome
      vlc
      spotify
      discord
      postman # mostly for work
      windsurf # AI cursor editor
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
