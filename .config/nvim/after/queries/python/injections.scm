; extends

; #MISE format
((comment) @injection.content
  (#lua-match? @injection.content "^#MISE ")
  (#offset! @injection.content 0 6 0 1)
  (#set! injection.language "toml"))

; #[MISE] format
((comment) @injection.content
  (#lua-match? @injection.content "^#%[MISE%] ")
  (#offset! @injection.content 0 8 0 1)
  (#set! injection.language "toml"))

; # [MISE] format
((comment) @injection.content
  (#lua-match? @injection.content "^# %[MISE%] ")
  (#offset! @injection.content 0 9 0 1)
  (#set! injection.language "toml"))

; #USAGE format
; multi node pattern (nvim >= 0.12) - preferred over combined injections
((comment)+ @injection.content
  (#lua-match? @injection.content "^#USAGE ")
  (#offset! @injection.content 0 7 0 1)
  (#set! injection.language "kdl"))

; #[USAGE] format
((comment)+ @injection.content
  (#lua-match? @injection.content "^#%[USAGE%] ")
  (#offset! @injection.content 0 9 0 1)
  (#set! injection.language "kdl"))

; # [USAGE] format
((comment)+ @injection.content
  (#lua-match? @injection.content "^# %[USAGE%] ")
  (#offset! @injection.content 0 10 0 1)
  (#set! injection.language "kdl"))