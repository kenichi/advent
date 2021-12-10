defmodule Advent do
  # @segments %{
  #   0 => 6,
  #   1 => 2,
  #   2 => 5,
  #   3 => 5,
  #   4 => 4,
  #   5 => 5,
  #   6 => 6,
  #   7 => 3,
  #   8 => 7,
  #   9 => 6
  # }

  @uniques [
    2, # 1
    4, # 4
    3, # 7
    7  # 8
  ]

  @spec eval(List.t()) :: Integer.t()
  def eval(notes \\ Advent.Input.parse()) do
    Enum.map(notes, &count_uniques/1)
    |> Enum.sum()
  end

  def count_uniques({_, digits}) do
    digits
    |> Enum.filter(fn d -> String.length(d) in @uniques end)
    |> length()
  end
end
