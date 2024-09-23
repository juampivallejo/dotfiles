{ ... }:

{
  # Enable VPN
  programs.openvpn3.enable = true;

  services.openvpn.servers = {
    # Not working for now at least with SSO: docs in https://nixos.wiki/wiki/OpenVPN
    reptrakVPN = { config = "config ~/.config/openvpn/reptrakDevelop.ovpn"; };
  };
}
