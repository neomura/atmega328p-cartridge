.ifdef NTSC
  .ifdef PAL_60
    .error "Both NTSC and PAL_60 have been defined."
  .else
    .include "engine/interrupt/declarations/video-standards/ntsc.asm"
  .endif
.else
  .ifdef PAL_60
    .include "engine/interrupt/declarations/video-standards/pal-60.asm"
  .else
    .error "Neither NTSC nor PAL_60 have been defined."
  .endif
.endif
