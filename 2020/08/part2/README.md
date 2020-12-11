# Advent of Code 2020 - Day 8 Part 2

What is the value of the accumulator after the program terminates?

We have to change one :jmp or one :nop to the other to make it run all the way
to the end.

## Implementation

Start with a list of indices with either a :jmp or :nop. Iterate this, flipping
the instruction, and test for repeats. If it succeeds, return accumulator value.

## Running

`mix run`

## Testing

`mix test`
