# Advent of Code 2020 - Day 5 Part 2

What's your seat id?

## Implementation

Removed the test for `eval/1` since there were no examples to test with in the
puzzle. Then, removed the sort, reverse, hd to find the highest (should've used
`Enum.max/1` in the first place); and assigned the whole list to `seat_ids`. A
filter function on a generator that walks through all values between 0 and the
max tests to make sure the id is not in the list, and that the seats +/-1 from
it are.

## Running

`mix run`

## Testing

`mix test`
