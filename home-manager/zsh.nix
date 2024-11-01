{ pkgs, ... }: {
  # Zsh
  programs.zsh = {
    # Your zsh config
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "docker" "vi-mode" "fzf" ];
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion = { enable = true; };

    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake .";
      home-update = "home-manager switch --flake .";
      zshconfig = "vim ~/.zshrc";
      ohmyzsh = "vim ~/.oh-my-zsh";
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

    initExtra = ''
      # FZF-TAB Config
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false

      # set descriptions format to enable group support
      # NOTE: dont use escape sequences here, fzf-tab will ignore them
      zstyle ':completion:*:descriptions' format '[%d]'

      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no

      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'

      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

      # give a preview of commandline arguments when completing `kill`
      zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
        '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

      # Preview Environment variables
      zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ''${(P)word}'

      # Preview systemctl status
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

      # Preview files depending on type
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ''${(Q)realpath}'
      export LESSOPEN='|~/.config/scripts/.lessfilter %s'
    '';

    defaultKeymap = "viins";
  };

  home.file."./.config/.lessfilter" = {
    source = ./scripts/lessfilter.sh;
    executable = true;
  };
  home.packages = with pkgs; [
    file # Required for lessfilter
    lesspipe # Required for lessfilter
  ];
}
