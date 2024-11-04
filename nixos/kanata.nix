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
              hold-time 150
              tap-time-slow 260
              hold-time-slow 220

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
              to-base (layer-switch base)
            )
            (defalias
              tap (multi
                (layer-switch nomods)
                (on-idle-fakekey to-base tap 20)
              )

              caps (tap-hold $tap-time $hold-time esc lsft)
              a (tap-hold-release-keys $tap-time-slow $hold-time-slow (multi a @tap) lmet $left-hand-keys)
              s (tap-hold-release-keys $tap-time-slow $hold-time-slow (multi s @tap) lalt $left-hand-keys)
              d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lsft $left-hand-keys)
              f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lctl $left-hand-keys)
              j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rctl $right-hand-keys)
              k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rsft $right-hand-keys)
              l (tap-hold-release-keys $tap-time-slow $hold-time-slow (multi l @tap) ralt $right-hand-keys)
              ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
            )
          '';
        };
      };
    };
    # services.kanata = {
    #   enable = true;
    #   keyboards = {
    #     internalKeyboard = {
    #       # devices = [ ];
    #       extraDefCfg = "process-unmapped-keys yes";
    #       config = ''
    #         (defsrc
    #          ;; (;; for comments)
    #          ;; caps a s d f j k l ;
    #          caps ;
    #         )
    #         (defvar
    #          tap-time 150
    #          hold-time 200
    #         )
    #         (defalias
    #          caps (tap-hold $tap-time $hold-time esc lmet)
    #          ; (tap-hold $tap-time $hold-time ; rmet)
    #          ;; a (tap-hold $tap-time $hold-time a lmet)
    #          ;; s (tap-hold $tap-time $hold-time s lalt)
    #          ;; d (tap-hold $tap-time $hold-time d lsft)
    #          ;; f (tap-hold $tap-time $hold-time f lctl)
    #          ;; j (tap-hold $tap-time $hold-time j rctl)
    #          ;; k (tap-hold $tap-time $hold-time k rsft)
    #          ;; l (tap-hold $tap-time $hold-time l ralt)
    #          ;; ; (tap-hold $tap-time $hold-time ; rmet)
    #         )
    #
    #         (deflayer base
    #          ;; @caps @a  @s  @d  @f  @j  @k  @l  @;
    #          @caps @;
    #         )
    #       '';
    #     };
    #   };
    # };
  };
}
