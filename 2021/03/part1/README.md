# Advent of Code 2021 - Day 3 Part 1

What is the power consumption of the submarine?

## Setup

Now, we've got binary to parse, but we also want to get these gamma and epsilon
values out of the list. Let's start by changing input parsing to return a list
of tuples of each binary value.

## Implementation

We can walk through the list of tuples, creating our gamma and epsilon values
by summing the column and, if greater than half the length, know if it is 1 or
0. Only do this once, invert gamma to get epsilon. This gives us our values,
which we convert to decimal and multiply.

## Running

`mix run`

## Testing

Moved tests out of doctests for formatting.

`mix test`
