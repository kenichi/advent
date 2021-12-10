# Advent of Code 2021 - Day 8 Part 1

In the output values, how many times do digits 1, 4, 7, or 8 appear?

## Setup

Parse into a list of 2-elem tuples: first being a list of 10 unique patterns
per display, second the list of 4 digit outputs.

## Implementation

We drop the first list on the floor and only inspect the second for string
lengths that match the unique segments we're looking for.

## Running

`mix run`

## Testing

`mix test`
