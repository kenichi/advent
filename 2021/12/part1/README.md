# Advent of Code 2021 - Day 12 Part 1

How many paths through this cave system are there that visit small caves at
most once?

## Setup

We start with a simple split parse on `-`, coverting to tuples, and getting a
list of `{cave, cave}` "tunnels". Thinking of each cave like a Zork map spot
with exits, and using Elixir's pattern matching, writing the `Advent.exits/2`
function helped immensely.

## Implementation

Honestly, surprised this worked and was fast. See `Advent.build_paths/3`:

 * generate possible paths from here
 * find path that ends (should only ever be zero or one)
 * add any that end to main list (ok if empty)
 * get the rest of the possibilities
 * filter any out that result in small cave repeat
 * iterate through any left

## Running

`mix run`

## Testing

`mix test`
