defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(MapSet.new(), &reduce_line/2)
  end

  defp reduce_line(line, set) do
    line
    |> String.split(" -> ", trim: true)
    |> Enum.map(&map_vertex/1)
    |> line_points()
    |> Enum.reduce(set, &MapSet.put(&2, &1))
  end

  defp map_vertex(vertex) do
    vertex
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp line_points(vertices) do
    vertices
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce([], &reduce_vertices/2)
  end

  defp reduce_vertices([{ax, ay}, {bx, by}], list) when ax == bx,
    do: for(y <- ay..by, do: {ax, y}) ++ list

  defp reduce_vertices([{ax, ay}, {bx, by}], list) when ay == by,
    do: for(x <- ax..bx, do: {x, ay}) ++ list
end
