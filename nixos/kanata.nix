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
            ;; Home row mods QWERTY example with more complexity.
            ;; Some of the changes from the basic example:
            ;; - when a home row mod activates tap, the home row mods are disabled
            ;;   while continuing to type rapidly
            ;; - tap-hold-release helps make the hold action more responsive
            ;; - pressing another key on the same half of the keyboard
            ;;   as the home row mod will activate an early tap action

            (defsrc
              caps a   s   d   f   j   k   l   ;
            )
            (defvar
              ;; Note: consider using different time values for your different fingers.
              ;; For example, your pinkies might be slower to release keys and index
              ;; fingers faster.
              tap-time 200
              hold-time 170
              hold-time-slow 200

              left-hand-keys (
                q w e r t
                a s d f g
                z x c v b
              )
              right-hand-keys (
                y u i o p
                h j k l ;
                n m , . /
              )
            )
            (deflayer base
              @caps @a  @s  @d  @f  @j  @k  @l  @;
            )

            (deflayer nomods
              @caps a   s   d   f   j   k   l   ;
            )
            (deffakekeys
              to-base (layer-switch base) ;; the to-base key will switch to the base layer (with mods)
            )
            (defalias
              tap (multi
                (layer-switch nomods)  ;; each tap deactivates mods
                (on-idle-fakekey to-base tap 20) ;; When kanata has ben idle for 20ms, "tap" (action) the "to-base" virtual (fake) key
              )

              caps (tap-hold $tap-time $hold-time esc lctl)
              a (tap-hold-release-keys $tap-time $hold-time-slow (multi a @tap) lalt $left-hand-keys)
              s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lctl $left-hand-keys)
              d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lmet $left-hand-keys)
              f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
              j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
              k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rmet $right-hand-keys)
              l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) rctl $right-hand-keys)
              ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) ralt $right-hand-keys)
            )
          '';
        };
      };
    };
  };
}
