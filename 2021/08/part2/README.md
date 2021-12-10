# Advent of Code 2021 - Day 8 Part 2

What do you get if you add up all of the output values?

## Setup

Stick with our 2-elem tuples, but make the inside bits charlists. This makes
it easy to "subtract" other charlists via `--` without ordering, etc.

## Implementation

We start with our known numbers: 1, 4, 7, 8. We can grok these out of the
segment list just like before. Then we can apply logic rules to find the other
numbers. 2, 3, & 5 are all 5 segments; 0, 6 & 9 are all 6.

Since 9 is inclusive of 4 segment-wise, but 0 & 6 are not, we can "subtract" 0,
6, & 9 from 4, and determine 9 be seeing which operation leaves no segments.
Once we have 9, we can just look at 0 & 6. Since 0 is inclusive of 7
segment-wise, but 6 is not, we do the same thing and determine 0. The leftover
is 6.

Slightly different, 5 is inclusive of 6 save 1 segment, whereas 2 & 3 are
inclusive save 2 segments. We can filter the same way, just looking for one
segment left instead of none.

Then we sort the segment ids, so we can match the jumbled output et voila.

## Running

`mix run`

## Testing

`mix test`
