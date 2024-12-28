# Advent of Code 2024 - Day 10 Part 2

What is the sum of the ratings of all trailheads?

## Setup

Parse into coordinate map, saving off 0s (trailheads).

## Implementation

Iterate trailheads and determine ratings, i.e. number of *distinct* paths to a
9. Sum ratings. Actually was easier than part1, just incremented a counter
instead of using a `MapSet` to de-dupe.

## Running

`mix run`

## Testing

`mix test`

