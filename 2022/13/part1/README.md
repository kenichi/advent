# Advent of Code 2022 - Day 13 Part 1

Determine which pairs of packets are already in the right order. What is the sum
of the indices of those pairs?

## Setup

* split by double newline first
* split by newline
* map by `Code.eval_string/1`

## Implementation

* `cond` is the heart of the `ordered_pair?` function
* support each condition mentioned in the puzzle via pattern matching
* `true` and `false` as halters, `nil` as continuer
* filter, map to index, sum

## Running

`mix run`

## Testing

`mix test`

