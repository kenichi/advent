defmodule Advent do
  @moduledoc false

  defstruct disk: %{}, files: %{}, max_id: 0, max_pos: 0

  @type file_id :: integer()

  @type position :: integer()

  @type disk :: %{position() => file_id()}

  @type size :: integer()

  @type entry :: {position(), size()}

  @type t :: %__MODULE__{
          disk: disk(),
          files: %{file_id() => entry()},
          max_id: file_id(),
          max_pos: position()
        }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> fs_checksum()
  end

  @spec fs_checksum(t()) :: integer()
  def fs_checksum(advent) do
    advent
    |> defrag()
    |> checksum()
  end

  @spec defrag(t()) :: t()
  defp defrag(%__MODULE__{max_id: id} = advent), do: defrag(advent, id)

  @spec defrag(t(), file_id()) :: t()
  defp defrag(advent, 0), do: advent

  defp defrag(%__MODULE__{disk: disk, files: files} = advent, id) do
    {pos, size} = files[id]

    free_pos =
      Enum.reduce_while(0..pos, nil, fn p, nil ->
        if Enum.all?(p..(p + size - 1), &is_nil(Map.get(disk, &1))) do
          {:halt, p}
        else
          {:cont, nil}
        end
      end)

    advent =
      if free_pos do
        disk = Enum.reduce(pos..(pos + size - 1), disk, &Map.delete(&2, &1))
        disk = Enum.reduce(free_pos..(free_pos + size - 1), disk, &Map.put(&2, &1, id))

        %__MODULE__{advent | disk: disk}
      else
        advent
      end

    defrag(advent, id - 1)
  end

  @spec checksum(t()) :: integer()
  defp checksum(%__MODULE__{} = advent) do
    Enum.reduce(0..advent.max_pos, 0, fn pos, sum ->
      case Map.get(advent.disk, pos) do
        nil -> sum
        id -> sum + pos * id
      end
    end)
  end
end
