# Advent of Code 2024 - Day 6 Part 1

How many distinct positions will the guard visit before leaving the mapped area?

## Setup

Parse into struct of obstacle coordinates, maxes, and start position.

## Implementation

Build position set, iterating on the movement rules. Once guard is out of the
area, return set size.

## Running

`mix run`

## Testing

`mix test`

