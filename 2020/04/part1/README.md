# Advent of Code 2020 - Day 4 Part 1

How many valid passports?

## Implementation

First, we change `Advent.Input.read/1` to split on `\n\n` so we get each
passport as a String. Then, `parse/1` uses `Enum.into/3` to split and convert
keys to atoms so we wind up with atom/string maps.

`Advent.eval/1` then became a simple sum-reduce, with the added pattern-matched
validator function that increases the count if valid.

## Running

`mix run`

## Testing

`mix test`
