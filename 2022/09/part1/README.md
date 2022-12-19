# Advent of Code 2022 - Day 9 Part 1

How many positions does the tail of the rope visit at least once?

## Setup

Reverted to line splitting.

## Implementation

* model head moves
* model tail following
* simulate according to directions
* add tail position to `MapSet` and call `MapSet.size/1`

## Running

`mix run`

## Testing

`mix test`

