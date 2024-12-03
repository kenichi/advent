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
    memory
    |> remove_disabled()
    |> scan()
    |> Enum.sum()
  end

  @spec scan(String.t()) :: [integer()]
  defp scan(memory) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(memory)
    |> Enum.map(&map_mul/1)
  end

  @spec map_mul([String.t()]) :: integer()
  defp map_mul([_match, a, b]) do
    String.to_integer(a) * String.to_integer(b)
  end

  @spec remove_disabled(String.t()) :: String.t()
  defp remove_disabled(memory) do
    ~r/don't\(\).*?do\(\)/
    |> Regex.scan(memory)
    |> Enum.reduce(memory, &reduce_memory/2)
  end

  @spec reduce_memory([String.t()], String.t()) :: String.t()
  defp reduce_memory([match], memory) do
    String.replace(memory, match, "")
  end
end
