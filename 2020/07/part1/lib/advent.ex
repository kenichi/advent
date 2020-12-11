defmodule Advent do
  @moduledoc false

  @doc """
  Return count of colors that can eventually contain at least one shiny gold
  bag.
  """
  @spec eval(List.t()) :: integer()
  def eval(rules \\ Advent.Input.parse()) do
    rules
    |> Map.keys()
    |> Enum.reduce(0, fn color, count ->
      if can_hold?(rules, color, :shiny_gold), do: count + 1, else: count
    end)
  end

  @doc """
  Returns true if container can hold at least one of the specified color,
  according to the given rules.

  ## Examples

    iex> Advent.can_hold?(%{a: [b: 2]}, :a, :b)
    true

    iex> Advent.can_hold?(%{a: [b: 2], b: [c: 1]}, :a, :c)
    true

    iex> Advent.can_hold?(%{a: [b: 2], b: [c: 1]}, :a, :d)
    false

    iex> Advent.can_hold?(%{a: nil, b: [c: 1]}, :a, :b)
    false

  """
  @spec can_hold?(Map.t(), atom(), atom()) :: boolean()
  def can_hold?(rules, container, color) do
    case Map.get(rules, container) do
      nil ->
        false

      content ->
        case Keyword.get(content, color) do
          nil ->
            Enum.any?(content, fn
              {_, qty} when qty == 0 ->
                false

              {content_color, _} ->
                can_hold?(rules, content_color, color)
            end)

          qty when qty == 0 ->
            false

          qty ->
            true
        end
    end
  end
end
