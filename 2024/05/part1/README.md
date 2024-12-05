# Advent of Code 2024 - Day 5 Part 1

What do you get if you add up the middle page number from those correctly-
ordered updates?

## Setup

Parse into struct of rules and updates.

## Implementation

Iterate each update and sort according to the rules. Filter those that already
match, and sum their middle values.

## Running

`mix run`

## Testing

`mix test`

