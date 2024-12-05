# Advent of Code 2024 - Day 5 Part 2

What do you get if you add up the middle page numbers after correctly ordering
just those updates?

## Setup

Parse into struct of rules and updates.

## Implementation

Iterate each update and sort according to the rules. Filter those that DO NOT
already match, take the sorted results, and sum their middle values.

## Running

`mix run`

## Testing

`mix test`

