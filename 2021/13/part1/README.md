# Advent of Code 2021 - Day 13 Part 1

How many dots are visible after completing just the first fold instruction on
your transparent paper?

## Setup

Parse into a head list of points and a tail of folds in tuples of axis and
value.

## Implementation

See `Advent.transpose_from/1` for the action. This creates a list of tuples do
remap the folded points along an axis.

With good old `MapSet`, we can put our points in and "overlap". Actually,
implemented the whole walk through the folds, then commented out and just did
the first.

## Running

`mix run`

## Testing

`mix test`
