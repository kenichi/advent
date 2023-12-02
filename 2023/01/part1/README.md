# Advent of Code 2023 - Day 1 Part 1

Find calibration integers.

## Setup

Parse the input into lines, then split each line into single-char strings, and
walk from each direction until the first integer is encountered. Put them
together, parse, and sum.

## Implementation

`Enum.reduce_while/3` is the jam here.

## Running

`mix run`

## Testing

`mix test`

