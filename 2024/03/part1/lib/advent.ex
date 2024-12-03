defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> mul_sum()
  end

  @doc """
  Sum the products of the "real" mul() calls.
  """
  @spec mul_sum(String.t()) :: integer()
  def mul_sum(memory) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(memory)
    |> Enum.map(&map_mul/1)
    |> Enum.sum()
  end

  @spec map_mul([String.t()]) :: integer()
  defp map_mul([_match, a, b]) do
    String.to_integer(a) * String.to_integer(b)
  end
end
