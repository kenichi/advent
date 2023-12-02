defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> calibration_sum()
  end

  @doc """
  Find the first and last integers in the string, combine string-wise, parse, and sum.
  """
  @spec calibration_sum([String.t()]) :: integer()
  def calibration_sum(list) do
    list
    |> Enum.map(&first_and_last/1)
    |> Enum.sum()
  end

  defp first_and_last(str) do
    strs = String.split(str, "", trim: true)
    first = first_int(strs)
    last = Enum.reverse(strs) |> first_int()
    String.to_integer("#{first}#{last}")
  end

  defp first_int(strs) do
    Enum.reduce_while(strs, nil, &parse_int/2)
  end

  defp parse_int(str, _acc) do
    case Integer.parse(str) do
      {_, _} -> {:halt, str}
      :error -> {:cont, nil}
    end
  end
end
