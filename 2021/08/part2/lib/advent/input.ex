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
    Enum.map(lines, fn line ->
      line
      |> String.split(" | ", trim: true)
      |> Enum.map(fn d ->
        String.split(d, " ", trim: true) |> Enum.map(&to_charlist/1)
      end)
      |> List.to_tuple()
    end)
  end
end
