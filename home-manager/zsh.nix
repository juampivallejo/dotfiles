{ pkgs, ... }:
{
  # Zsh
  programs.zsh = {
    # Your zsh config
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "docker" "vi-mode" ];
    };
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake .";
      home-update = "home-manager switch --flake .";
      zshconfig = "vim ~/.zshrc";
      ohmyzsh = "vim ~/.oh-my-zsh";

      # NeoVim default
      vim = "nvim";
      # Eza replace ls
      ls = "eza";
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
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = ".p10k.zsh";
      }
    ];

    defaultKeymap = "viins";
  };
}
