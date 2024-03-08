{ ... }: {

  home.file."./.config/hypr/" = {
    source = ./hypr;
    recursive = true;
  };
  home.file."./.config/tmux/" = {
    source = ./tmux;
    recursive = true;
  };
  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
