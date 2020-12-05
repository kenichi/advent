# Advent of Code 2020 - Day 2 Part 2

Count the valid passwords according to the NEW interpretation of the policies.

## Implementation

Starting off by changing the parse, we can simplify by returning the integers,
rather than a range. Furthermore, we can adjust for zero-based indexes along the
way by subtracting one. Then, in `eval/1`, we map each position to equality, and
pattern match for "exactly one".

## Running

`mix run`

## Testing

`mix test`
