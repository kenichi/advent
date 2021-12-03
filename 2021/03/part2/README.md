# Advent of Code 2021 - Day 3 Part 2

What is the life support rating of the submarine?

## Setup

Building on the parsing from part 1, glad we used Tuples.

## Implementation

Bit significance again plays a large role. We add a significance argument to
our function, which takes the form of a comparison atom: `:>=` or `:<`, such
that it can be used with `apply/3`. Choosing properly lets us build the ratings
for each subsystem and then multiply like before.

## Running

`mix run`

## Testing

Moved tests out of doctests for formatting.

`mix test`
