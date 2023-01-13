# Advent of Code 2022 - Day 13 Part 2

Organize all of the packets into the correct order. What is the decoder key for
the distress signal?

## Setup

* split by newline, trim empties
* map by `Code.eval_string/1`

## Implementation

* `ordered_pair?` -> `sorter/2`
* dropped need to carry index through
* add dividers, sort, find divider indices, multiply

## Running

`mix run`

## Testing

`mix test`

