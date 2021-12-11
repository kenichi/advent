defmodule Advent.Input do
  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  @spec parse(List.t()) :: List.t()
  def parse(lines \\ read()) do
    my = length(lines) - 1
    mx = (lines |> hd() |> String.length()) - 1

    map =
      for x <- 0..mx, y <- 0..my, into: %{} do
        {{x, y}, Enum.at(lines, y) |> String.at(x) |> String.to_integer()}
      end

    {map, mx, my}
  end
end
