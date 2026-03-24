{ ... }:

{
  # Enable VPN
  programs.openvpn3.enable = true;

  # Wifi Hotspot config
  # environment.systemPackages = with pkgs; [ linux-wifi-hotspot hostapd iw ];
  # networking.firewall = {
  #   enable = true;
  #   allowedUDPPorts = [ 53 67 ];
  # };

  # environment.systemPackages = [ pkgs.cloudflare-warp ]; # for warp-svc
  # systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  # systemd.targets.multi-user.wants =
  #   [ "warp-svc.service" ]; # causes warp-svc to be started automatically

  # services.openvpn.servers = {
  #   # Not working for now at least with SSO: docs in https://nixos.wiki/wiki/OpenVPN
  #   workVPN = {
  #     config = "config /home/juampi/.config/openvpn/workDevelop.conf";
  #   };
  # };
}
