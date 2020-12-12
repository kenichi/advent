# Advent of Code 2020 - Day 9 Part 1

What is the first number that is not the sum of two of the 25 numbers before
it?

## Implementation

Gathering out bits, we slice off our preamble of the specified size (the puzzle
example uses 5, but the question uses 25), and start iterating through the rest
as numbers recieved from the port. As we're only concerned with the last
preamble size pool, we build a `rotate/2` helper function to "shift and push".
A `drop_first/2` helper lets us check for any possible `sum_of_preambles?/2`.
With all these in hand, we can continue through until we find the invalid
number.

## Running

`mix run`

## Testing

`mix test`
