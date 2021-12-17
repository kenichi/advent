# Advent of Code 2021 - Day 14 Part 1

What do you get if you take the quantity of the most common element and
subtract the quantity of the least common element?

## Setup

Let's use charlists. Easy to parse into, and use all the power of `Enum` with.

Might regret this if the next part is run it a 1,000 times or something.

## Implementation

Reduce the given template, the given (default 10) number of times, according
to the insertion rules. Using `Enum.chunk_every/4`, we get easy groups of
charslists, and build a new charlist from the template. Start with the head,
then append either just the next char or the inserted and next. This protects
from unwanted repeats.

## Running

`mix run`

## Testing

`mix test`
