# Advent of Code 2021 - Day 5 Part 1

At how many points do at least two lines overlap?

## Setup

Went a bit overboard I think at first, adding GCD and slope, was probably
more than needed for part1, but will pay off for part2 ease. Essentially,
I wanted to build a map of coordinates that lines touched, incrementing and
filtering to get the answer.

## Implementation

All good, got 12, then remembered the part1 instructions of only vertical or
horizontal lines. Perhaps just removing that filter will work for part2.

## Running

`mix run`

## Testing

`mix test`
