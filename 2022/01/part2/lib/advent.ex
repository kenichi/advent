defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  @spec eval() :: integer
  def eval() do
    Advent.Input.parse()
    |> top_three_total()
  end

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
end
