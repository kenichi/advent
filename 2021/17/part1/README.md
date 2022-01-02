# Advent of Code 2021 - Day 17 Part 1

What is the highest y position it reaches on this trajectory?

## Setup

Start off with a `Regex` to get our starting and ending X and Y values. This
gives us our target values to check against and velocity ranges to calculate
paths from.

## Implementation

Step logic was fairly simple, see `Advent.step/1`. Finding the right range to
build our paths with proved to be just a decent guess then fitler down.

## Running

`mix run`

## Testing

`mix test`
