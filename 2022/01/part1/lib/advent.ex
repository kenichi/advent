defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_calories()
  end

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
end
