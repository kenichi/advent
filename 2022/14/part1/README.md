# Advent of Code 2022 - Day 14 Part 1

How many units of sand come to rest before sand starts flowing into the abyss
below?

## Setup

* split by newline
* reduce to `MapSet` of rocks, via `for` comprehensions
* `Enum.chunk_every/4` comes in very handy

## Implementation

* first, compute the max depth; anything beyond is `:infinity`
* use the iterative function is `drop_sand/3` which increments a unit counter
  each time it is called
* call itself until the next sand unit falls off (returns `:infinity`)

## Running

`mix run`

## Testing

`mix test`

