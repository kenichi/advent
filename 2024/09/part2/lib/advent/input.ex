defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @type acc :: {Advent.t(), integer(), integer()}

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.t()
  def parse(input \\ read()) do
    {advent, id, pos} =
      input
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2, 2)
      |> Enum.reduce({%Advent{}, 0, 0}, &reduce_chunk/2)

    %Advent{advent | max_id: id - 1, max_pos: pos - 1}
  end

  @spec reduce_chunk([integer()], acc()) :: acc()
  defp reduce_chunk([file, free], {advent, id, pos}) do
    new_disk = Enum.reduce(pos..(pos + file - 1), advent.disk, &Map.put(&2, &1, id))
    new_files = Map.put(advent.files, id, {pos, file})

    advent = %Advent{advent | disk: new_disk, files: new_files}

    {advent, id + 1, pos + file + free}
  end

  defp reduce_chunk([file], acc), do: reduce_chunk([file, 0], acc)
end
