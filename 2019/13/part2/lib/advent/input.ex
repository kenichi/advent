defmodule Advent.Input do
  def file(path \\ "../input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.split(",", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end
end
