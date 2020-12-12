# Advent of Code 2020 - Day 9 Part 2

What is the encryption weakness in your XMAS-encrypted list of numbers?

## Implementation

We keep our old `eval/1` around as `first_invalid/1`, adjusting tests
accordingly. Then we start off with that return value as our `target`. Now, it's
time to find the slice of the numbers list that sums to this value. With the
return of `initial_slice_range/1`, we can loop on each possible slice size. Then
we loop through each possible starting slice index in `reduce_slice_sums/3`, and
testing against the target in `slice_sum_to/4`. Once we have that slice, simply
add the min and max.

## Running

`mix run`

## Testing

`mix test`
