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
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
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
              grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps @a   @s   @d   @f   g    h    @j   @k   @l   @;   '    ret
              lsft  z    x    c    v    b    n    m    ,    .    /    rsft
              lctl  lmet lalt           spc            ralt rmet rctl
            )
            (deflayer nomods
              grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft  z    x    c    v    b    n    m    ,    .    /    rsft
              lctl  lmet lalt           spc            ralt rmet rctl
            )
            (deflayer magic
              grv   f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  bspc
              tab   q    up   e    r    t    y    u    i    o    p    [    ]    \
              @caps left down rght _    g    h    j    k    l    ;    '    ret
              lsft  z    x    @csc @csv C-b  n    m    grv  .    /    rsft
              lctl  lmet lalt           spc            ralt rmet rctl
            )
            (deffakekeys
              to-base (layer-switch base) ;; the to-base key will switch to the base layer (with mods)
            )
            (defalias
              tap (multi
                (layer-switch nomods)  ;; each tap deactivates mods
                (on-idle-fakekey to-base tap 20) ;; When kanata has ben idle for 20ms, "tap" (action) the "to-base" virtual (fake) key
              )

              caps (tap-hold $tap-time $hold-time esc (layer-while-held magic))
              a (tap-hold-release-keys $tap-time $hold-time-slow (multi a @tap) lalt $left-hand-keys)
              s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lctl $left-hand-keys)
              d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lmet $left-hand-keys)
              f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
              j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
              k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rmet $right-hand-keys)
              l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) rctl $right-hand-keys)
              ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) ralt $right-hand-keys)

              ;; Useful chords aliases
              csv C-S-v
              csc C-S-c
            )
          '';
        };
      };
    };
  };
}
