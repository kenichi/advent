# Advent of Code 2022 - Day 6 Part 1

How many characters need to be processed before the first start-of-packet marker is detected?

## Setup

Dialed parsing all back to just `String.codepoints/1` for this one.

## Implementation

* `Enum.reduce_while/3` is always good for these odd find first type questions
* continue building our list until we have at least 4
* once 4, check for uniqueness, halt at index if so

## Running

`mix run`

## Testing

`mix test`

