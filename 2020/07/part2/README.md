# Advent of Code 2020 - Day 7 Part 2

How many individual bags are required inside your single shiny gold bag?

## Implementation

Seems like we can just walk the graph in the same way pretty easily. The wording
of the puzzle had me a bit more worried, as in the past these advents have had
some sneaky edge cases hiding in there. But this turned out pretty quick.

We can remove all that `can_hold?/3` stuff and make a new `count_bags/3` with a
default count of 0. Checking for the color in the rules, we return count
immediately if nil, meaning "no other bags." Otherwise, we sum up the count of
each contained bags, plus what those contain multiplied by their quantity.
Sounds scary maybe, but [reads pretty easy](lib/advent.ex#L19).

## Running

`mix run`

## Testing

`mix test`
