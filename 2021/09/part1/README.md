# Advent of Code 2021 - Day 9 Part 1

What is the sum of the risk levels of all low points on your heightmap?

## Setup

I might've started with a 2d array, but something tells me I should go with a
coordinate map (constant access), so that's what I'll set up.

## Implementation

Once we have our coordinate map, it's a filter walk through each point and a
test for surrounding higher points. Remember to sum up the "risk" (height + 1).

## Running

`mix run`

## Testing

`mix test`
