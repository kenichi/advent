# Advent of Code 2021 - Day 1 Part 1

How many measurements are larger than the previous measurement?

## Setup

Again, ripped a bunch of infra from last year's code, like `Advent.Input` and
main application, etc. Then, using the `doctest` directive and Examples section,
including the example entries from the puzzle was easy and it created a
working bit of documentation along the way.

## Implementation

`Advent.Input.read/1` gets us each line of the input file, and
`Advent.Input.parse/1` maps those to integers. Having `Advent.eval/1` take a 
List as its param makes doctesting easy.

`Enum.chunk_every/4` is our friend today. This gives us each pair, and saves us
the hassle of discarding the last single. Simple reduction counter of greater-
thans gives our answer.

## Running

`mix run`

## Testing

`mix test`
