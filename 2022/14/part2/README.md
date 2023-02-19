# Advent of Code 2022 - Day 14 Part 2

How many units of sand come to rest? (now there's a floor)

## Setup

* split by newline
* reduce to `MapSet` of rocks, via `for` comprehensions
* `Enum.chunk_every/4` comes in very handy

## Implementation

* first, compute the max depth; add two, and then add "floor" to `blocks`, using
  `@x_tolerance`
* raise if we run out of width (need up the `@x_tolerance`)
* add to new `sands` MapSet as well as `blocks`
* add `full?/1` which simply checks for the three below source to be there
* call itself until full
* return `MapSet.size(sands)`

## Running

`mix run`

## Testing

`mix test`

