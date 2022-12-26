defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  @cap_e 69
  @cap_s 83
  @a 97
  @z 122

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> gradient_map()
  end

  defp gradient_map(lines) do
    lines
    |> Enum.map(&String.to_charlist/1)
    |> Enum.reduce({{0, 0}, %{}, [], nil}, &reduce_map/2)
    |> Tuple.delete_at(0)
  end

  defp reduce_map(line, acc) do
    line
    |> Enum.reduce(acc, &reduce_line/2)
    |> increment_y()
  end

  defp reduce_line(height, {{x, y} = crd, map, starts, finish}) do
    {map, starts, finish} =
      case height do
        @cap_s -> {Map.put(map, crd, @a), [crd | starts], finish}
        @a -> {Map.put(map, crd, @a), [crd | starts], finish}
        @cap_e -> {Map.put(map, crd, @z), starts, crd}
        h -> {Map.put(map, crd, h), starts, finish}
      end

    {{x + 1, y}, map, starts, finish}
  end

  defp increment_y({{_x, y}, m, s, f}), do: {{0, y + 1}, m, s, f}
end
