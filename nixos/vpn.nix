{ pkgs-old, ... }:

{
  # Enable VPN
  programs.openvpn3.enable = true;
  programs.openvpn3.package =
    pkgs-old.openvpn3; # TODO: remove pkgs-old after openvpn3 works

  # services.openvpn.servers = {
  #   # Not working for now at least with SSO: docs in https://nixos.wiki/wiki/OpenVPN
  #   workVPN = {
  #     config = "config /home/juampi/.config/openvpn/workDevelop.conf";
  #   };
  # };
}
