# Advent of Code 2022 - Day 10 Part 1

What is the sum of these six signal strengths?

## Setup

Same.

## Implementation

* reduce initial state (cycle, x, signals) over the instructions
* check each cycle, save signal if needed
* double calls to `next_cycle/1` in `cycle/2` are a bit messy but easy for this
  puzzle

## Running

`mix run`

## Testing

`mix test`

