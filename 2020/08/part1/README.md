# Advent of Code 2020 - Day 8 Part 1

Immediately before any instruction is executed a second time, what value is in
the accumulator?

## Implementation

Oh boy here we go. Once we start implementing instructions... I have a feeling
this will grow.

We'll start off with a struct, holding the instructions, accumulator, and
pointer. Outside of that, we'll keep a history, set in this case since we want
to stop immediately before repeat. If a new instruction line is set to be
executed when it exists in the history set already, we'll stop and return the
accumulated value.

## Running

`mix run`

## Testing

`mix test`
