defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> total_distance()
  end

  @doc """
  Calculate "total distance" between the lists.
  """
  @spec total_distance({[integer()], [integer()]}) :: integer()
  def total_distance(lists, sum \\ 0)

  @spec total_distance({[integer()], [integer()]}, integer()) :: integer()
  def total_distance({[l | left], [r | right]}, sum) do
    total_distance({left, right}, sum + abs(l - r))
  end

  def total_distance({[], []}, sum), do: sum
end
