defmodule Advent do
  @spec eval(List.t()) :: Integer.t()
  def eval(bts \\ Advent.Input.parse()) do
    g = gamma(bts)
    e = epsilon(g)
    tuple_to_decimal(g) * tuple_to_decimal(e)
  end

  def gamma(bts) do
    x = hd(bts)
    s = tuple_size(x) - 1
    Enum.reduce(0..s, x, fn i, x -> put_elem(x, i, significant_bit(bts, i)) end)
  end

  def epsilon(gamma) do
    s = tuple_size(gamma) - 1
    Enum.reduce(0..s, gamma, fn i, e ->
      n = if elem(e, i) == 0, do: 1, else: 0
      put_elem(e, i, n)
    end)
  end

  def significant_bit(bts, index) do
    sum =
      bts
      |> Enum.map(& elem(&1, index))
      |> Enum.sum()

    mid = length(bts) / 2

    if sum > mid, do: 1, else: 0
  end

  def tuple_to_decimal(t) do
    s = tuple_size(t) - 1
    Enum.reduce(0..s, "", fn i, s -> s <> Integer.to_string(elem(t, i)) end)
    |> Integer.parse(2)
    |> elem(0)
  end
end