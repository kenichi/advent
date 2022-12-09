# Advent of Code 2022 - Day 5 Part 1

After the rearrangement procedure completes, what crate ends up on top of each stack?

## Setup

Parsing the input became the major task this time.

* split into stacks and steps
* parse stacks by first finding count at end of stack number row
* `String.codepoints/1` and `Enum.at/2` to fetch crates
* couple of reductions into a `Map` of stack index => `List` of crates
* parse steps by regex, decrementing into stack index

## Implementation

* follow the steps to move crates amongst stacks

## Running

`mix run`

## Testing

`mix test`

