# Advent of Code 2021 - Day 1 Part 2

How many sums are larger than the previous sum?

## Implementation

This took an extra couple runs through the list, but `Enum` functions make life
easy. We only had to add two lines: first chunk_by 3, then sum the chunks.

## Running

`mix run`

## Testing

`mix test`
