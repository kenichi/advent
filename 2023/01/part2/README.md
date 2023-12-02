# Advent of Code 2023 - Day 1 Part 2

Find calibration integers sometimes with words.

## Setup

Hardcode a map of digit words to string digits, for combining later. Instead
of walking each char, slice the string iteratively and check for digit words.
If found, return the string digit value to combine and sum.

## Implementation

`String.slice/3` joins `Enum.reduce_while/3` in the fun.

## Running

`mix run`

## Testing

`mix test`

