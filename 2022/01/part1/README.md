# Advent of Code 2022 - Day 1 Part 1

Find the Elf carrying the most Calories. How many total Calories is that Elf
carrying?

## Setup

We start by saving our puzzle input as `input.txt`. Then, we create
`Advent.Input` module to read/parse the input file. This lets us add a handy
setup block to our tests, so we can use the same parsing code. Usually, test
input is much smaller, and fits nicely in a module attribute.

## Implementation

```elixir
@doc """
Walk through calorie list, summing for each elf, determining most at each
blank line.
"""
def count_calories(list) do
{_, most} =
  Enum.reduce(list, {0, 0}, fn line, {elf, most} ->
    case line do
      "" ->
        if elf > most, do: {0, elf}, else: {0, most}

      num ->
        {String.to_integer(num) + elf, most}
    end
  end)

most
end
```

## Running

`mix run`

## Testing

`mix test`

