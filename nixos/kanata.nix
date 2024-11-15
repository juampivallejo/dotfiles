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

            (defalias
              ;; Useful chords aliases
              csv C-S-v
              csc C-S-c
              tp C-S-tab
              tn C-tab

              ;; TMUX next previous windows and session
              tmpw (macro C-b p)
              tmnw (macro C-b n)
              tmps (macro C-b S-9)
              tmns (macro C-b S-0)

              tmpws (fork @tmpw @tmps (left))
              tmnws (fork @tmnw @tmns (left))

              ;; tmux split vertical and horizontal
              tmv (macro C-b S-5)
              tmh (macro C-b S-')
              tms (fork @tmv @tmh (left))

              ;; tmux closing
              tmx  (macro C-b x)             ;; close
              tmxx  (macro C-b S-x)          ;; close without confirm
              tmq  (fork @tmx @tmxx (left))

              ;; tmux other
              tmc  (macro C-b c)  ;; new window
              tmw  (macro C-b w)  ;; sessions list
              tmf  (macro C-b o)  ;; fuzzy
              tmgo (fork @tmf @tmw (left))
            )

            (deflayer base
              grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps @a   @s   @d   @f   g    h    @j   @k   @l   @;   @'    ret
              lsft  z    x    c    v    b    n    m    ,    .    /    rsft
              lctl  lmet lalt           spc            ralt rmet rctl
            )
            (deflayer nomods
              grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps a    s    d    f    g    h    j    k    l    ;    @'   ret
              lsft  z    x    c    v    b    n    m    ,    .    /    rsft
              lctl  lmet lalt           spc            ralt rmet rctl
            )

            ;; _ means transparent, for me no point to remap them since draconic already does
            (deflayer magic
              grv    f1    f2     f3     f4     f5     f6      f7    f8     f9     f10    f11     f12  bspc
              tab    q     up     e      r      t      y       u     @tn    @tp    _      _       _    @tms
              @caps  left  down   rght   _      @tmgo  @tmpws  j     k      @tmnws _      _       ret
              lsft   z     @tmq   @csc   @csv   C-b    @tmc    m     grv    _      _      rsft
              lctl   lmet  lalt                 spc                  ralt   rmet   rctl
            )
            (defvirtualkeys
              to-base (layer-switch base) ;; the to-base key will switch to the base layer (with mods)
            )
            (defalias
              tap (multi
                (layer-switch nomods)  ;; each tap deactivates mods
                (on-idle-fakekey to-base tap 20) ;; When kanata has ben idle for 20ms, "tap" (action) the "to-base" virtual (fake) key (key, action, idle-time)
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
              ' (tap-hold $tap-time $hold-time ' (layer-while-held magic))
              mbck (tap-hold $tap-time $hold-time mbck lctl)
              mfwd (tap-hold $tap-time $hold-time mfwd lmet)
            )
          '';
        };
      };
    };
  };
}
