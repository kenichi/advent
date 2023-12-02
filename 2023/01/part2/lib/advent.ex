defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> calibration_sum()
  end

  @digits %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  @doc """
  Find the first and last integers in the string, combine, parse, and sum.
  """
  @spec calibration_sum([String.t()]) :: integer()
  def calibration_sum(list) do
    list
    |> Enum.map(&first_and_last/1)
    |> Enum.sum()
  end

  defp first_and_last(str) do
    first = first_value(str)
    last = last_value(str)
    String.to_integer("#{first}#{last}")
  end

  defp is_int_str?(str) do
    case Integer.parse(str) do
      {_, _} -> true
      :error -> false
    end
  end

  defp first_value(str) do
    max = String.length(str) - 1
    find_value(str, 0..max, max)
  end

  defp last_value(str) do
    max = String.length(str) - 1
    find_value(str, max..0, max)
  end

  defp find_value(str, range, max) do
    Enum.reduce_while(range, nil, fn i, v ->
      char = String.at(str, i)
      if is_int_str?(char) do
        {:halt, char}
      else
        bit = String.slice(str, i, max)
        case find_digit(bit) do
          nil -> {:cont, v}
          digit -> {:halt, digit}
        end
      end
    end)
  end

  defp find_digit(str) do
    @digits
    |> Map.keys()
    |> Enum.find(&String.starts_with?(str, &1))
    |> case do
      nil -> nil
      digit -> @digits[digit]
    end
  end
end
