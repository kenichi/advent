# Advent of Code 2022 - Day 11 Part 1

What is the level of monkey business after 20 rounds of stuff-slinging simian
shenanigans?

## Setup

Split by two new lines first, then each by new line. This gives us a 5-element
List of a monkey.

## Implementation

* parse monkey lists into `Monkey` structs, mapped by "id"
* iterate the inspection rounds twenty times
* get inspection counts, sort desc, slice 2, multiply

## Running

`mix run`

## Testing

`mix test`

