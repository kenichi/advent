defmodule Advent.Input do
  def file(path \\ "../input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn l ->
      Regex.named_captures(~r/<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/, l)
      |> Enum.map(fn {k, v} ->
        {i, ""} = Integer.parse(v)
        {String.to_atom(k), i}
      end)
      |> Map.new()
    end)
  end
end
