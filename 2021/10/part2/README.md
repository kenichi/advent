# Advent of Code 2021 - Day 10 Part 2

What is the middle score?

## Setup

Same.

## Implementation

We walk the list, building our stack, and open or close blocks along the way,
depending on the current block. Ignoring corrupted lines, we can see what's left
to close by examining the stack once our line is exhausted. Then it's just the
math of points.

## Running

`mix run`

## Testing

`mix test`
