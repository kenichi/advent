# Advent of Code 2021 - Day 2 Part 1

What do you get if you multiply your final horizontal position by your final
depth?

## Setup

Have to change `Input.parse/1` do handle these instructions. Map each into a
tuple of instruction atom and value.

## Implementation

We'll start with a tuple of {position, depth} i.e. `{0, 0}`. Then we'll walk
each instruction via reductions, and multiply the results.

## Running

`mix run`

## Testing

`mix test`
