; The bit representing the right face button in a pad's state.
.equ PADS_BUTTON_FACE_RIGHT = 0

; The bit representing the left face button in a pad's state.
.equ PADS_BUTTON_FACE_LEFT = 1

; The bit representing the select button in a pad's state.
.equ PADS_BUTTON_SELECT = 2

; The bit representing the start button in a pad's state.
.equ PADS_BUTTON_START = 3

; The bit representing the up button in a pad's state.
.equ PADS_BUTTON_UP = 4

; The bit representing the down button in a pad's state.
.equ PADS_BUTTON_DOWN = 5

; The bit representing the left button in a pad's state.
.equ PADS_BUTTON_LEFT = 6

; The bit representing the right button in a pad's state.
.equ PADS_BUTTON_RIGHT = 7

; The state of pad 0.
; Set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right.
; All cleared when pad disconnected.
.def pad_0 = r2

; The state of pad 1.
; Set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right.
; All cleared when pad disconnected.
.def pad_1 = r3

; The state of pad 2.
; Set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right.
; All cleared when pad disconnected.
.def pad_2 = r4

; The state of pad 3.
; Set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right.
; All cleared when pad disconnected.
.def pad_3 = r5
