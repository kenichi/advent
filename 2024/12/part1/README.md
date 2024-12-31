# Advent of Code 2024 - Day 12 Part 1

What is the total price of fencing all regions on your map?

## Setup

First, parse into complete coordinate map. From there, build region sets by
examining neighbors, filtering by plant and membership.

## Implementation

Iterate each region set, determining area (`MapSet.size/1`) and perimeter, and
multiplying. Perimeter is determined by iterating each plot, and subtracting 1
from 4 for each neighbor in the same set. Sum costs.

## Running

`mix run`

## Testing

`mix test`

