# Advent of Code 2021 - Day 11 Part 2

What is the first step during which all octopuses flash?

## Setup

Same.

## Implementation

Toss out the counter. Only check the number of flashed octopii each step, but
count steps. When that number is 100, return the step. Hopefully, the existing
implementation is efficient enough.

## Running

`mix run`

## Testing

`mix test`
