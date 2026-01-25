{ lib, pkgs, ... }:
{
  # Fish shell configuration
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -U __done_notification_command "notify-send \$title \$message"
    '';

    plugins = [
      {
        name = "git-abbr";
        src = pkgs.fishPlugins.git-abbr.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    shellAbbrs = {
      gst = "git status";
      # Lazy
      ld = "lazydocker";
    };
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
    enable = false;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      scan_timeout = 10;
      format = lib.concatStrings [
        "$os"
        "$directory"
        "$vcsh"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$git_metrics"
        "$kubernetes"
        "$fill"
        "$nix_shell"
        "$python"
        "$rust"
        "$time"
        "$line_break" # new line before the character
        "$character"
      ];

      fill = {
        symbol = "-";
      };
      git_metrics = {
        disabled = false;
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
      };
      os = {
        disabled = false;
        symbols = {
          NixOS = " ";
        };
      };
      python = {
        disabled = false;
        format = "[(\${version} )(($virtualenv) )]($style)";
        version_format = "\${major}.\${minor}";
      };
      nix_shell = {
        disabled = false;
        format = "[ $state]($style) ";
      };
      time = {
        disabled = false;
        format = "[$time]($style) ";
      };
    };
  };
}
