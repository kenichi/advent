# Advent of Code 2022 - Day 12 Part 1

What is the fewest steps required to move from your current position to the
location that should get the best signal?

## Setup

* parse each line into charlists
* reduce into a coordinate map, with start and finish coordinates
* charlists are literally Lists of ascii values, so built-in heights

## Implementation

* pull a dijkstra + prioritized list implementation from last year, day 15
* refactor for current use
    * heights (map values) are for filtering available steps, not adding
      distance
    * just add one for each step

## Running

`mix run`

## Testing

`mix test`

