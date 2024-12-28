defmodule Advent do
  @moduledoc false

  defstruct map: %{}, max: 0, min: 0

  @type t :: %__MODULE__{
          map: map(),
          max: integer(),
          min: integer()
        }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> fs_checksum()
  end

  @doc """
  Checksum the filesystem after defrag.
  """
  @spec fs_checksum(t()) :: integer()
  def fs_checksum(advent) do
    advent
    |> update_min()
    |> defrag()
    |> checksum()
  end

  @spec update_max(t()) :: t()
  defp update_max(%Advent{map: map, max: max, min: min} = advent) do
    Enum.reduce_while(max..min, nil, fn p, _ ->
      if Map.has_key?(map, p) do
        {:halt, %Advent{advent | max: p}}
      else
        {:cont, nil}
      end
    end)
  end

  @spec update_min(t()) :: t()
  defp update_min(%Advent{map: map, max: max, min: min} = advent) do
    Enum.reduce_while(min..max, advent, fn p, a ->
      a = %Advent{a | min: p}

      if Map.has_key?(map, p) do
        {:cont, a}
      else
        {:halt, a}
      end
    end)
  end

  @spec defrag(t()) :: t()
  defp defrag(%Advent{map: map, max: max, min: min} = advent) do
    id = Map.get(map, max)

    map =
      map
      |> Map.delete(max)
      |> Map.put(min, id)

    advent =
      %Advent{advent | map: map, max: max - 1}
      |> update_max()
      |> update_min()

    if advent.min == advent.max do
      advent
    else
      defrag(advent)
    end
  end

  @spec checksum(t()) :: integer()
  defp checksum(%Advent{map: map, min: min}) do
    Enum.reduce(0..min, 0, fn p, cs -> cs + p * Map.get(map, p) end)
  end
end
