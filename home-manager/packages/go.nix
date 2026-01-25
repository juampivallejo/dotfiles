{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Golang Dev
    go
    gopls
    sqlc
  ];
}
