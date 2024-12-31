{ pkgs-old, ... }:

{
  # Enable VPN
  programs.openvpn3.enable = true;
  programs.openvpn3.package = pkgs-old.openvpn3;

  # services.openvpn.servers = {
  #   # Not working for now at least with SSO: docs in https://nixos.wiki/wiki/OpenVPN
  #   reptrakVPN = {
  #     config = "config /home/juampi/.config/openvpn/reptrakDevelop.conf";
  #   };
  # };
}
