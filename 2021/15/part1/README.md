# Advent of Code 2021 - Day 15 Part 1

What is the lowest total risk of any path from the top left to the bottom
right?

## Setup

We again want our coorindate map (see day 9). This time, I'm going to use `for`
and `Enum.with_index/1` a bit more. We can build this nicely with a generator.
That also gives us a nice `Map` to call `Map.keys/1` on to get our initial `Q`.

## Implementation

[Pseudocode for Dijkstra's
algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode)

Basically, implemented the exact pseudocode via `Dijkstra.shortest/2`. Used the
risk values for length, which worked out nicely. Did not use a priority queue as
the program finished in not too long, but will probably need one for part 2.

## Running

`mix run`

## Testing

`mix test`
