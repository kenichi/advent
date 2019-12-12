defmodule Advent do
  @moduledoc false

  def input_file() do
    {:ok, dev} = File.open("../input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def layers(input \\ read_input(), width \\ 25, height \\ 6) do
    input
    |> Enum.chunk_every(width * height)
    |> Enum.map(&Enum.chunk_every(&1, width))
  end

  def eval(input \\ read_input()) do
    min_zeros =
      input
      |> layers()
      |> Enum.min_by(fn layer ->
        Enum.reduce(layer, 0, fn row, sum -> sum + Enum.count(row, &(&1 == 0)) end)
      end)

    ones =
      Enum.reduce(min_zeros, 0, fn row, sum -> sum + Enum.count(row, &(&1 == 1)) end)
    twos =
      Enum.reduce(min_zeros, 0, fn row, sum -> sum + Enum.count(row, &(&1 == 2)) end)

    ones * twos
  end
end
