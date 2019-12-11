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

  def path_to_com(map, object, path \\ []) do
    if object == "COM" do
      Enum.reverse(path)
    else
      next = Map.get(map, object)
      path_to_com(map, next, [next | path])
    end
  end

  def eval(map \\ read_input()) do
    from_you = path_to_com(map, "YOU")
    from_san = path_to_com(map, "SAN")

    ((from_you -- from_san) ++ (from_san -- from_you))
    |> length()
  end
end
