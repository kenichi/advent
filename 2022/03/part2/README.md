# Advent of Code 2022 - Day 3 Part 2

Find the item type that corresponds to the badges of each three-Elf group.
What is the sum of the priorities of those item types?

## Setup

No changes needed.

## Implementation

* `Enum.chunk_every/2` ftw
* added a `MapSet` and another `intersection/2` call for the third group

## Running

`mix run`

## Testing

`mix test`

