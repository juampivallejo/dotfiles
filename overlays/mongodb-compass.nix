final: prev: {
  # Set XDG_CURRENT_DESKTOP to GNOME for MongoDB Compass to use gnome keyring
  mongodb-compass-overlay = prev.mongodb-compass.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs or [ ] ++ [ final.makeWrapper ];
    buildCommand = ''
      ${oldAttrs.buildCommand or ""}
      wrapProgram $out/bin/mongodb-compass \
        --set XDG_CURRENT_DESKTOP GNOME
    '';
  });
}
