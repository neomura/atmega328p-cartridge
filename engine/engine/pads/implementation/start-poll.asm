; The main loop should be finished with pad state now, so lower the pad latch line before we start polling it on a future line.
cbi PORTC, 5
