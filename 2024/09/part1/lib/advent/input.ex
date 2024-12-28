defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @type acc :: {Advent.t(), integer(), integer()}

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.t()
  def parse(input \\ read()) do
    input
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 2)
    |> Enum.reduce({%Advent{}, 0, 0}, &reduce_chunk/2)
    |> elem(0)
  end

  @spec reduce_chunk([integer()], acc()) :: acc()
  defp reduce_chunk([file, free], {advent, id, pos}) do
    advent =
      Enum.reduce(pos..(pos + file - 1), advent, fn p, a ->
        %Advent{a | map: Map.put(a.map, p, id), max: Enum.max([a.max, p])}
      end)

    {advent, id + 1, pos + file + free}
  end

  defp reduce_chunk([file], acc), do: reduce_chunk([file, 0], acc)
end
