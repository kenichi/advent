# Advent of Code 2021 - Day 6 Part 1

How many lanternfish would there be after 80 days?

## Setup

Iterative state management based on integers. `Enum.reduce/3` is
the best.

## Implementation

Start with our list of fish. Iterate N days, each day casing on
value: either subtracting 1 or restting to 6 and incrementing
spawn count. Generator threw me for a bit because `for _ <- 1..0`
will build a 2-element list, so cased on 0 specifically.

## Running

`mix run`

## Testing

`mix test`
