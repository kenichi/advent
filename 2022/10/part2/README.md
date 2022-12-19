# Advent of Code 2022 - Day 10 Part 2

What eight capital letters appear on your CRT?

## Setup

Same.

## Implementation

* switch signals for lines
* check each cycle, build line by drawing pixels
* make sure the "index" was correct (`Integer.mod(cycle - 1, 40)`)

## Running

`mix run`

## Testing

`mix test`

