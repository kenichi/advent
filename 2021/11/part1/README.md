# Advent of Code 2021 - Day 11 Part 1

How many total flashes are there after 100 steps?

## Setup

Back to our map of points for constant access time. We just need some support
functions to build up our model.

## Implementation

`surroundings/` returns a filtered list of points, cardinal & diagonal. This is
used in each flash step, and each flash cycle repeats until all octupii have
flashed. When one flashes, replace with `"*"` and ignore for the rest of the
step. At the end of the step, count and add the `"*"` while resetting to `0`.

Do this 100 times.

## Running

`mix run`

## Testing

`mix test`
