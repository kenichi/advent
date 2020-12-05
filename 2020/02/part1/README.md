# Advent of Code 2020 - Day 2 Part 1

Count the valid passwords according to their policies at the time.

## Setup

From here, I just copy the previous and clean out or extend. See day 01.

## Implementation

Most of this was in the parse: getting each line into a range, character, and
password string tuple. Once that was [done](lib/advent/input.ex), we count valid
passwords with `Enum.count/2`, the function of which counts occurences of the
character in the password, then tests for that quantity in the range.

## Running

`mix run`

## Testing

`mix test`
