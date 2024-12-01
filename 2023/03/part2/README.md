# Advent of Code 2023 - Day 3 Part 2

Sum of gear ratios.

## Setup

Easier with the impl from day 1. Stashed the gears in the struct along with
each part's coordinates, then filtered by those that had two using `case`.

## Implementation

`Schematic` and `Part` know what they need to, and `Advent.udpate_part` handles
the main logic, with `Advent.update_parts` following up with state.

## Running

`mix run`

## Testing

`mix test`

