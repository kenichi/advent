defmodule Advent do

  @spec eval(List.t()) :: Integer.t()
  def eval(notes \\ Advent.Input.parse()) do
    notes
    |> Enum.map(&decode_numbers/1)
    |> Enum.sum()
  end

  def decode_numbers({input, output}) do
    nm = number_map(input)

    output
    |> Enum.map(& Map.get(nm, Enum.sort(&1)))
    |> Integer.undigits()
  end

  def number_map(input) do
    %{
      2 => [one],
      3 => [seven],
      4 => [four],
      5 => two_three_five,
      6 => zero_six_nine,
      7 => [eight]
    } = Enum.group_by(input, &length/1)

    [nine] = leaves_none(zero_six_nine, four)
    [zero] = leaves_none(zero_six_nine -- [nine], seven)
    [six] = zero_six_nine -- [zero, nine]

    [five] = leaves_one(two_three_five, six)
    [three] = leaves_one(two_three_five -- [five], nine)
    [two] = two_three_five -- [three, five]

    [zero, one, two, three, four, five, six, seven, eight, nine]
    |> Enum.with_index()
    |> Enum.map(fn {n, d} -> {Enum.sort(n), d} end)
    |> Map.new()
  end

  def leaves_none(numbers, mask) do
    Enum.filter(numbers, fn n -> match?([], mask -- n) end)
  end

  def leaves_one(numbers, mask) do
    Enum.filter(numbers, fn n -> match?([_], mask -- n) end)
  end
end
