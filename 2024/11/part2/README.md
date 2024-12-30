# Advent of Code 2024 - Day 11 Part 2

How many stones will you have after blinking *75* times?

## Setup

Parse into frequency map of integer counts.

## Implementation

`change/1` implements the "rules" by reducing a new frequency map out of the
existing one. Sum all the values in the map for total count.

## Running

`mix run`

## Testing

`mix test`

