{ pkgs, ... }: {
  home.packages = with pkgs; [
    # TypeScript Dev
    vtsls
    vscode-js-debug
  ];
}
