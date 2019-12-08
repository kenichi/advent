defmodule Advent do
  @moduledoc false

  def input_file() do
    {:ok, dev} = File.open("../input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def fuel_for(mass) do
    Integer.floor_div(mass, 3) - 2
  end

  def total_fuel_for(mass, total \\ 0) do
    f = fuel_for(mass)
    if f > 0, do: total_fuel_for(f, total + f), else: total
  end

  def sum_fuel() do
    read_input()
    |> Enum.map(&total_fuel_for/1)
    |> Enum.sum()
  end

  def eval() do
    sum_fuel()
    |> IO.puts()
  end
end
