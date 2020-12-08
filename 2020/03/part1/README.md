# Advent of Code 2020 - Day 3 Part 1

How many trees would you encounter?

## Implementation

Parsing the input into a `Map` lets us generate the coordinates of the toboggan
at each row, then check if there's a tree or not. We need the width and height
to know our modulo and iteration bounds, respectively. It took me waaaaay too
long to realize I left out the `=` from the `>=` in the check because the test
input will pass without it. Sigh.

## Running

`mix run`

## Testing

`mix test`
