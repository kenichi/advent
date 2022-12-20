# Advent of Code 2022 - Day 11 Part 2

What is the level of monkey business after 10000 rounds?

## Setup

Same.

## Implementation

* same impl, but remove the divide by 3 worry relief
* to keep worry down, start by finding the LCM of all the `test` values
* use LCM to modulo the worry, chinese remainder theorem says this is congruent

## Running

`mix run`

## Testing

`mix test`

