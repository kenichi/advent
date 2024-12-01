# Advent of Code 2023 - Day 4 Part 1

Sum of points.

## Setup

Regex out the prefix and split-split into MapSets.

## Implementation

`MapSet.intersection/2` + `MapSet.size/1` are the key functions here. Points
are just 2 to the power of intersection size - 1.

## Running

`mix run`

## Testing

`mix test`

