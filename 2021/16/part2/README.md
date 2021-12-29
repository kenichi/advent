# Advent of Code 2021 - Day 16 Part 2

What do you get if you evaluate the expression represented by your hexadecimal-
encoded BITS transmission?

## Setup

Parsed packets made it fairly easy. Add in Elixir's pattern matching on
function parameters and `eval_packet/1` practically wrote itself.

## Implementation

See `Advent.eval_packet/1` and its various incarnations. The added
`packet_value/1` helper made things even easier. TIL: `Enum.product/1` exists.

## Running

`mix run`

## Testing

`mix test`
