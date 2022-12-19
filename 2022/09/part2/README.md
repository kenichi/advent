# Advent of Code 2022 - Day 9 Part 2

Simulate your complete series of motions on a larger rope with ten knots. How
many positions does the tail of the rope visit at least once?

## Setup

Same.

## Implementation

* add 8 positions, switch to :a, :b, :c...
* refactor touching and follow to take arbitrary pairs
* `Enum.chunk_every/3` makes it easy to iterate each pair

## Running

`mix run`

## Testing

`mix test`

