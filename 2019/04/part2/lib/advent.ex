defmodule Advent do
  @moduledoc false

  def six_digits?(n), do: n > 99999 && n < 1_000_000

  def in_range?(n), do: n >= 231_832 && n <= 767_346

  def adjacent_digits?(n) do
    digits = Integer.digits(n)

    digits
    |> Enum.uniq()
    |> Enum.map(fn n -> Enum.map(digits, fn x -> x == n end) end)
    |> Enum.any?(&any_two/1)
  end

  defp any_two([true, true, false, false, false, false]), do: true
  defp any_two([false, true, true, false, false, false]), do: true
  defp any_two([false, false, true, true, false, false]), do: true
  defp any_two([false, false, false, true, true, false]), do: true
  defp any_two([false, false, false, false, true, true]), do: true
  defp any_two([_, _, _, _, _, _]), do: false

  def never_decreases?(n) do
    Integer.digits(n)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a <= b end)
  end

  def valid?(n) do
    six_digits?(n) &&
      in_range?(n) &&
      adjacent_digits?(n) &&
      never_decreases?(n)
  end

  def eval() do
    Enum.reduce(231_832..767_346, 0, fn n, count ->
      if valid?(n), do: count + 1, else: count
    end)
  end
end
