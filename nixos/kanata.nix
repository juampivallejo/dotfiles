{ pkgs, lib, config, ... }: {
  options = { homeRowMod.enable = lib.mkEnableOption "Enables Home Row Mods"; };

  config = lib.mkIf config.homeRowMod.enable {
    # Remaps home rows to be modifiers when hold
    # Pressing a key twice fast (tap-time) makes it behave as normal key (spam key)
    # Holding a key press makes it behave like super key (met), alt, shift or control

    environment.systemPackages = with pkgs; [ kanata ];

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          # devices = [ ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
             ;; (;; for comments)
             ;; caps a s d f j k l ;
             caps ;
            )
            (defvar
             tap-time 150
             hold-time 200
            )
            (defalias
             caps (tap-hold $tap-time $hold-time esc lmet)
             ; (tap-hold $tap-time $hold-time ; lmet)
             ;; a (tap-hold $tap-time $hold-time a lmet)
             ;; s (tap-hold $tap-time $hold-time s lalt)
             ;; d (tap-hold $tap-time $hold-time d lsft)
             ;; f (tap-hold $tap-time $hold-time f lctl)
             ;; j (tap-hold $tap-time $hold-time j rctl)
             ;; k (tap-hold $tap-time $hold-time k rsft)
             ;; l (tap-hold $tap-time $hold-time l ralt)
             ;; ; (tap-hold $tap-time $hold-time ; rmet)
            )

            (deflayer base
             ;; @caps @a  @s  @d  @f  @j  @k  @l  @;
             @caps @;
            )
          '';
        };
      };
    };
  };
}
