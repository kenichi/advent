defmodule Advent do
  @moduledoc false

  def input_file() do
    {:ok, dev} = File.open("../input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn orbit ->
      orbit
      |> String.split(")", trim: true)
      |> Enum.reverse()
      |> List.to_tuple()
    end)
    |> Map.new()
  end

  def path_to_com(object, map, count \\ 0) do
    if object == "COM" do
      count
    else
      path_to_com(Map.get(map, object), map, count + 1)
    end
  end

  def eval(map \\ read_input()) do
    map
    |> Map.keys()
    |> Enum.map(&path_to_com(&1, map))
    |> Enum.sum()
  end
end
