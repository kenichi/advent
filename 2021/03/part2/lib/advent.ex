defmodule Advent do
  @spec eval(List.t()) :: Integer.t()
  def eval(bts \\ Advent.Input.parse()) do
    ogr = oxygen_generator_rating(bts)
    csr = co2_scrubber_rating(bts)
    tuple_to_decimal(ogr) * tuple_to_decimal(csr)
  end

  def oxygen_generator_rating(bts, i \\ 0)
  def oxygen_generator_rating([ogr], _), do: ogr
  def oxygen_generator_rating([_|_] = bts, i) do
    b = significant_bit(bts, i)
    Enum.filter(bts, &(elem(&1, i) == b))
    |> oxygen_generator_rating(i + 1)
  end

  def co2_scrubber_rating(bts, i \\ 0)
  def co2_scrubber_rating([csr], _), do: csr
  def co2_scrubber_rating([_|_] = bts, i) do
    b = significant_bit(bts, i, :<)
    Enum.filter(bts, &(elem(&1, i) == b))
    |> co2_scrubber_rating(i + 1)
  end

  def significant_bit(bts, index, sig \\ :>=) do
    ones =
      bts
      |> Enum.map(& elem(&1, index))
      |> Enum.sum()

    zeros = length(bts) - ones

    if apply(Kernel, sig, [ones, zeros]), do: 1, else: 0
  end

  def tuple_to_decimal(t) do
    s = tuple_size(t) - 1
    Enum.reduce(0..s, "", fn i, s -> s <> Integer.to_string(elem(t, i)) end)
    |> Integer.parse(2)
    |> elem(0)
  end
end