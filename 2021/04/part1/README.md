# Advent of Code 2021 - Day 4 Part 1

What will your final score be if you choose that board?

## Setup

This is gonna require a bit more infra. We'll need game state, which will take
the form of a two elem tuple, the list of numbers called and the boards as 2d
tuples themselves. We'll build lists out of them for Enum fun.

## Implementation

Most of the meat is in `Advent.Board` - functions for fetching and putting
specific board cells, getting the rows and columns, seeing if a board wins, and
summing all the leftover cells. Then the game walks through `Advent.turn/2`,
which feeds nicely into `Enum.reduce_while/3`.

## Running

`mix run`

## Testing

`mix test`