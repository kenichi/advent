# Advent of Code 2023 - Day 5 Part 1

What is the lowest location number that corresponds to any of the initial seed
numbers?

## Setup

Parsed into `Almanac` with lists of `Almanac.Mapping` under `{:from, :to}`
keys.

## Implementation

`Almanac.Mapping.map/2` ultimately handles the conversion, if any; and returns
a tuple with a flag so reducing can halt.

## Running

`mix run`

## Testing

`mix test`

