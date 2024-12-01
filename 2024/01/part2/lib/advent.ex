defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> similarity_score()
  end

  @doc """
  Calculate "similarity score" between the lists.
  """
  @spec similarity_score({[integer()], [integer()]}) :: integer()
  def similarity_score({left, right}) do
    right_counts =
      Enum.reduce(right, %{}, fn n, m ->
        Map.put(m, n, Map.get(m, n, 0) + 1)
      end)

    Enum.reduce(left, 0, fn n, s ->
      s + n * Map.get(right_counts, n, 0)
    end)
  end
end
