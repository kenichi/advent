# Advent of Code 2023 - Day 2 Part 1

Sum IDs of possible games.

## Setup

Regex time! Parse each line into an ID and sets (pulls from the bag). Compare
the sets to the rules (`@bag`), and sum the possible IDs.

## Implementation

`Regex.run` - for some reason the `raise` on line 25 is swallowed?

## Running

`mix run`

## Testing

`mix test`

