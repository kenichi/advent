# Advent of Code 2022 - Day 1 Part 2

Find the top three Elves carrying the most Calories. How many Calories are
those Elves carrying in total?

## Setup

Same as part 1.

## Implementation

```elixir
  @doc """
  Walk through calorie list, summing for each elf. Sort, then sum top 3.
  """
  @spec top_three_total(list) :: integer
  def top_three_total(list) do
    {_, elves} =
      Enum.reduce(list, {0, []}, fn line, {elf, elves} ->
        case line do
          "" ->
            {0, [elf | elves]}

          num ->
            {String.to_integer(num) + elf, elves}
        end
      end)

    elves
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.sum()
  end
```

## Running

`mix run`

## Testing

`mix test`
