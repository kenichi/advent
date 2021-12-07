# Advent of Code 2021 - Day 7 Part 1

How much fuel must they spend to align to that position?

## Setup

Parse like normal into a List of ints.

## Implementation

Reduce the range of `Enum.min_max/1` positions to a list of
fuel needed to align on that position. `fuel_for/2` does the 
"heavy lifting" of calculating cost. Simple `Enum.min/1` call
to get our answer.

## Running

`mix run`

## Testing

`mix test`
