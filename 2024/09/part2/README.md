# Advent of Code 2024 - Day 9 Part 2

What is the resulting filesystem checksum?

## Setup

Parse input into ints, chunks, and, finally, a map of positions to ids. Collect
file positions/size, max id and position along the way.

## Implementation

Many attempts at speed resulted in incorrect answers. 12s to finish part2 ain't
great, but I'm extremely *done* with this puzzle at this point 😅

Brutally iterate down the file IDs, checking for open space and flipping the
map keys when space is found.

## Running

`mix run`

## Testing

`mix test`

