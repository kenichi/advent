# Advent of Code 2021 - Day 7 Part 2

How much fuel must they spend to align to that position?

## Setup

New rules to implement in terms of fuel cost.

## Implementation

Adjusted `fuel_for/2` to call out to `sum_range/2` and calculate
the sum of the whole range faster and inclusive (`(n + 1)*n/2`).

## Running

`mix run`

## Testing

`mix test`
