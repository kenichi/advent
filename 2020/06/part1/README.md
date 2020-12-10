# Advent of Code 2020 - Day 6 Part 1

How many unique questions were answered yes?

## Implementation

Started off thinking of `MapSet`, but that seemed a bit heavy for this. May
regret it in part2...

First, we add another newline to `Advent.Input.read/1`'s split, so we get each
group of answers. Re-introduced `Advent.Input.parse/1` and had it split a
group's answers into individual chars (question IDs) after removing any
newlines. Feeding those lists to `Enum.uniq` before returning made the
implementation in `Advent.eval/1` a trivial map/length/sum operation.

## Running

`mix run`

## Testing

`mix test`
