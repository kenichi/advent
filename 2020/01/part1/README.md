# Advent of Code 2020 - Day 1 Part 1

Find the numbers that add to 2020 and multiply them.

## Setup

First, ripped a bunch of infra from last year's code, like `Advent.Input` and
main application, etc. Then, using the `doctest` directive and Examples section,
including the example entries from the puzzle there was easy and created a
working bit of documentation along the way.

## Implementation

`Advent.Input.read/1` gets us each line of the input file, and
`Advent.Input.parse/1` maps those to integers. Having `Advent.eval/1` take a 
List as its param makes doctesting easy.

This is just a brute force O(n^2) (i think haha) walk through the entries. The
puzzle text seemed to indicate that there would only be one match, so
`Enum.reduce_while` it is. Once we've found those pairs, multiply them for the
answer. Have `Main.start/2` print the result.

## Running

`mix run`

## Testing

`mix test`
