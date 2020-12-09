# Advent of Code 2020 - Day 5 Part 1

Whats the highest seat id?

## Implementation

First, removed extras from `Advent.Input` as we're just reading and splitting by
newline. Each line is a boarding pass, so from there we map them into seat IDs,
sort, reverse (to get highest first), and finally use our friend `hd()`.

The row and column decoding happens iteratively until there are no more
"directives" left, meaning the `F`, `B`, `L`, or `R`. At that point, we throw in
a guard just in case, making sure that the min and max are equal; if all is
well, return the value.

Seat ID follows the instructions of multiplying row by 8 and adding column.

## Running

`mix run`

## Testing

`mix test`
