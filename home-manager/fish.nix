{ pkgs, ... }: {
  # Fish shell configuration
  programs.fish = {
    # Your zsh config
    enable = true;
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" "python" "docker" "vi-mode" "fzf" ];
    # };
    # enableCompletion = true;
    # syntaxHighlighting.enable = true;
    # autosuggestion = { enable = true; };
    # sessionVariables = { MANPAGER = "nvim +Man!"; };
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';

    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake .";
      home-update = "home-manager switch --flake .";
      th = "tmux new -s home";

      # NeoVim default
      vim = "nvim";
      # Eza replace ls
      ls = "eza --group-directories-first";
      l = "eza -lbF";
      ll = "eza -lbGF";
      llm = "eza -lbGd --sort=modified";
      la = "eza -lbhHigUmuSa --time-style=long-iso --color-scale";
      lx = "eza -lbhHigUmuSa@ --time-style=long-iso --color-scale";
      lS = "eza -1";
      lt = "eza --tree --level=2";
      # BAT
      bat = "bat -p";
      cat = "bat -p";
      # Lazy
      ld = "lazydocker";
      lg = "lazygit";
    };
  };

  xdg.configFile.".lessfilter" = {
    text = ''
      #!/usr/bin/env bash
      mime=$(file -bL --mime-type "$1")
      category=''${mime%%/*}
      if [ -d "$1" ]; then
        eza -hl --color=always --icons "$1"
      else
        lesspipe.sh "$1" | bat --color=always -p
      fi
      # lesspipe.sh don't use eza, bat and chafa, it use ls and exiftool. so we create a lessfilter.
    '';
    executable = true;
  };

  home.packages = with pkgs; [
    file # Required for lessfilter
    lesspipe # Required for lessfilter
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      enable_transience = true;
    };
  };
}
