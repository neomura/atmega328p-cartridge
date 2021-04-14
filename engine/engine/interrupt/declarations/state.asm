; Selects the alternative palette when set; written from the row event handler when video_next_row is odd (1, 3, 5) and the frame event handler and read from by the interrupt when video_next_row is even (0, 2, 4).
.equ INTERRUPT_FLAG_PALETTE_A = 0

; Selects the alternative palette when set; written from the row event handler when video_next_row is even (0, 2, 4) and the frame event handler and read from by the interrupt when video_next_row is odd (1, 3, 5).
.equ INTERRUPT_FLAG_PALETTE_B = 1

; Alternates between set and cleared once per line when the video standard is PAL.
.equ INTERRUPT_FLAG_ALTERNATE_LINE = 2

; Flags used internally by the interrupt.  See INTERRUPT_FLAG_*.
.def interrupt_flags = r18

; The number of VSYNC lines per frame.
.equ INTERRUPT_VSYNC_LINES = 3

; The number of lines between the VSYNC and active lines.
.equ INTERRUPT_PRE_BLANK_LINES = 27

; The number of lines between the VSYNC and active lines.
.equ INTERRUPT_POST_BLANK_LINES = 9

; The first VSYNC line.
.equ INTERRUPT_STATE_VSYNC_START = 0

; The last VSYNC line.
.equ INTERRUPT_STATE_VSYNC_END = INTERRUPT_VSYNC_LINES - 1

; The first pre-active blank line.
.equ INTERRUPT_STATE_PRE_BLANK_START = INTERRUPT_VSYNC_LINES

; The last pre-active blank line.
.equ INTERRUPT_STATE_PRE_BLANK_END = INTERRUPT_STATE_VSYNC_END + INTERRUPT_PRE_BLANK_LINES

; The first repeat of an active line.
.equ INTERRUPT_STATE_ACTIVE_A = INTERRUPT_STATE_PRE_BLANK_END + 1

; The second repeat of an active line.
.equ INTERRUPT_STATE_ACTIVE_B = INTERRUPT_STATE_ACTIVE_A + 1

; The first post-active blank line.
.equ INTERRUPT_STATE_POST_BLANK_START = INTERRUPT_STATE_ACTIVE_B + 1

; The last post-active blank line.
.equ INTERRUPT_STATE_POST_BLANK_END = INTERRUPT_STATE_ACTIVE_B + INTERRUPT_POST_BLANK_LINES

; Tracks the progress through the current frame (see INTERRUPT_STATE_**).
.def interrupt_state = r17

; Pixel data, packed 4 pixels per byte, for a row being written to by the main loop when video_next_row is odd (1, 3, 5) and read from by the interrupt when video_next_row is even (0, 2, 4).
interrupt_framebuffer_a: .byte VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE

; Pixel data, packed 4 pixels per byte, for a row being written to by the main loop when video_next_row is even (0, 2, 4) and read from by the interrupt when video_next_row is odd (1, 3, 5).
interrupt_framebuffer_b: .byte VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE
