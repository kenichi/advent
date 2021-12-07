# Advent of Code 2021 - Day 6 Part 2

How many lanternfish would there be after 256 days?

## Setup

Ah, yes. The standard Advent of Code thing where part1 can be done naively,
but part2 asks for performant. In this case, the BEAM got OOM-killed on my
linode iterating on that list. We'll have to refactor to a map of counts at
states.

## Implementation

This went quick, and the map solution is much more elegant.

## Running

`mix run`

## Testing

`mix test`
