# Advent of Code 2024 - Day 6 Part 2

How many different positions could you choose for this obstruction?

## Setup

Parse into struct of obstacle coordinates, maxes, and start position.

## Implementation

Add an obstacle in a free position. Run through positions, checking for loop.
If loop, count position. Repeat with all free positions.

Figuring out the loop was hard. Brute forcing it like this may not be the most
elegant or efficient method, hence the need to "speed things up" by spreading
out into Tasks.

## Running

`mix run`

## Testing

`mix test`

