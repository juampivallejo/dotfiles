{ config }:

let
  mongodbCompass = import ./mongodb-compass.nix;
in
if config.enableHyprland then [ mongodbCompass ] else [ ]
