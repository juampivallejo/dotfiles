{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Rust Dev
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    vscode-extensions.vadimcn.vscode-lldb.adapter # For DAP
  ];
}
