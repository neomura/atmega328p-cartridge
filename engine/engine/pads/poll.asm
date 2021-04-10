.cseg

; - The bit which is being updated.
.macro pads_poll_update_button
  clt
  sbis PINC, 3
  set
  bld pad_0, @0

  clt
  sbis PINC, 2
  set
  bld pad_1, @0

  clt
  sbis PINC, 1
  set
  bld pad_2, @0

  clt
  sbis PINC, 0
  set
  bld pad_3, @0
.endm

; - The bit which is being updated.
; - The address of the next callback.
; - The address to jump to at the end.
.macro pads_poll_update_button_lower_clock
  pads_poll_update_button @0

  ; Lower the clock line.
  cbi PORTC, 4

  load_immediate_z @1
  rjmp @2
.endm

; - The address of the next callback.
; - The address to jump to at the end.
.macro pads_poll_raise_clock
  ; Raise the clock line.
  sbi PORTC, 4

  load_immediate_z @0
  rjmp @1
.endm

load_16_direct_z pads_poll_callback
ijmp

pads_poll_latched:
  ; Lower the latch line.
  cbi PORTC, 5
  load_immediate_z pads_poll_face_right
  rjmp pads_poll_end

pads_poll_face_right:
  pads_poll_update_button_lower_clock PADS_BUTTON_FACE_RIGHT, pads_poll_face_right_raise_clock, pads_poll_end

pads_poll_face_right_raise_clock:
  pads_poll_raise_clock pads_poll_face_left, pads_poll_end

pads_poll_face_left:
  pads_poll_update_button_lower_clock PADS_BUTTON_FACE_LEFT, pads_poll_face_left_raise_clock, pads_poll_end

pads_poll_face_left_raise_clock:
  pads_poll_raise_clock pads_poll_select, pads_poll_end

pads_poll_select:
  pads_poll_update_button_lower_clock PADS_BUTTON_SELECT, pads_poll_select_raise_clock, pads_poll_end

pads_poll_select_raise_clock:
  pads_poll_raise_clock pads_poll_start, pads_poll_end

pads_poll_start:
  pads_poll_update_button_lower_clock PADS_BUTTON_START, pads_poll_start_raise_clock, pads_poll_end

pads_poll_start_raise_clock:
  pads_poll_raise_clock pads_poll_up, pads_poll_end

pads_poll_up:
  pads_poll_update_button_lower_clock PADS_BUTTON_UP, pads_poll_up_raise_clock, pads_poll_end

pads_poll_up_raise_clock:
  pads_poll_raise_clock pads_poll_down, pads_poll_end

pads_poll_down:
  pads_poll_update_button_lower_clock PADS_BUTTON_DOWN, pads_poll_down_raise_clock, pads_poll_end

pads_poll_down_raise_clock:
  pads_poll_raise_clock pads_poll_left, pads_poll_end

pads_poll_left:
  pads_poll_update_button_lower_clock PADS_BUTTON_LEFT, pads_poll_left_raise_clock, pads_poll_end

pads_poll_left_raise_clock:
  pads_poll_raise_clock pads_poll_right, pads_poll_end

pads_poll_right:
  pads_poll_update_button PADS_BUTTON_RIGHT

  ; Raise the latch line.
  sbi PORTC, 5

  load_immediate_z pads_poll_latched

pads_poll_end:
store_16_direct_z pads_poll_callback
