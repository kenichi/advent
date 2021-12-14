defmodule Advent.Input do
  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
  end

  @spec parse(List.t()) :: List.t()
  def parse(content \\ read()) do
    [map, folds] = String.split(content, "\n\n", trim: true)

    map =
      map
      |> String.split("\n", trim: true)
      |> Enum.map(fn xy -> 
        String.split(xy, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    folds =
      folds
      |> String.split("\n", trim: true)
      |> Enum.map(fn "fold along " <> f ->
        String.split(f, "=")
        |> then(fn [axis, value] ->
          [String.to_atom(axis), String.to_integer(value)]
          |> List.to_tuple()
        end)
      end)

    [map | folds]
  end
end
