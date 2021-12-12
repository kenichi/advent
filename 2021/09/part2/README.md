# Advent of Code 2021 - Day 9 Part 2

What do you get if you multiply together the sizes of the three largest basins?

## Setup

This is key (emphasis added):

> Locations of height 9 do not count as being in any basin, and *all other
> locations will always be part of exactly one basin.*

We've got our map, and lowest points from part 1. That _should_ be enough.

## Implementation

`MapSet` to the rescue. Starting with each lowest point, build up a basin (set)
of points. Filter out any already found points during iteration, then simple
size call.

## Running

`mix run`

## Testing

`mix test`
