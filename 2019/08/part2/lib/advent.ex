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

  def combine(layers) do
    h = layers |> hd() |> length
    w = layers |> hd() |> hd() |> length

    for y <- 0..(h - 1), x <- 0..(w - 1) do
      Enum.map(layers, fn layer -> Enum.at(layer, y) |> Enum.at(x) end)
    end
    |> Enum.reduce([], fn pixels, img ->
      final =
        Enum.reduce_while(pixels, nil, fn pixel, final ->
          case pixel do
            0 -> {:halt, 0}
            1 -> {:halt, 1}
            2 -> {:cont, final}
          end
        end)

      [final | img]
    end)
    |> Enum.chunk_every(w)
  end

  def eval(input \\ read_input()) do
    input
    |> layers()
    |> combine()
    |> (fn rows ->
      Enum.reverse(rows)
      |> Enum.each(fn row ->
        Enum.reverse(row)
        |> Enum.each(fn pixel ->
          p = if pixel == 0, do: ".", else: "*"
          IO.write(p)
        end)
        IO.write("\n")
      end)
    end).()

    nil
  end
end
