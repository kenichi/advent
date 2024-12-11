# Advent of Code 2024 - Day 8 Part 2

How many unique locations within the bounds of the map contain an antinode?

## Setup

Parse input to map of frequencies to coordinates. Also save maxes (again).

## Implementation

Iterate each frequency, through each combination of coordinates, and generate
"antinodes". Put those that are valid in a set. Return the size of the set.

## Running

`mix run`

## Testing

`mix test`

