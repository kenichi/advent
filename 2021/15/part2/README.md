# Advent of Code 2021 - Day 15 Part 2

Using the full map, what is the lowest total risk of any path from the top left
to the bottom right?

## Setup

We have to take our original map, and 5x it out both ways, with risk values
increasing by one per rep.

## Implementation

`Advent.multiply_map/1` was fun. Implementing that `PrioritizedList` was cribbed
from the stream. Removal of `prev` and `generate_path/3` also cribbed.

## Running

`mix run`

## Testing

`mix test`
