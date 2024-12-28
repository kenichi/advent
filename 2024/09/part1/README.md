# Advent of Code 2024 - Day 9 Part 1

What is the resulting filesystem checksum?

## Setup

Parse input into ints, chunks, and, finally, a map of positions to ids. Collect
max position along the way.

## Implementation

Our struct as the position map, a max file position, and a min of 0. Start by
updating the min to the first free position (first consecutive number that is
not a key in the map). Swap the max and min, updating both, and continue until
they equal each other. Now, checksum the "defragged FS" via the method
described.

## Running

`mix run`

## Testing

`mix test`

