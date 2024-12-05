defmodule Advent do
  @moduledoc false

  defstruct rules: [], updates: []

  @type rule :: {integer(), integer()}

  @type update :: [integer()]

  @type t :: %__MODULE__{
          rules: [rule()],
          updates: [update()]
        }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> middle_sum()
  end

  @doc """
  Sum middle values of correclty ordered updates.
  """
  @spec middle_sum(Advent.t()) :: integer()
  def middle_sum(advent) do
    advent
    |> ordered_updates()
    |> Enum.map(&middle_value/1)
    |> Enum.sum()
  end

  @spec ordered_updates(t()) :: [update()]
  defp ordered_updates(%Advent{rules: rules, updates: updates}) do
    Enum.filter(updates, &ordered?(&1, rules))
  end

  @spec ordered?(update(), [rule()]) :: boolean()
  defp ordered?(update, rules), do: sort_update(update, rules) == update

  @spec sort_update(update(), [rule()]) :: update()
  defp sort_update(update, rules) do
    Enum.sort(update, fn a, b ->
      if Enum.find(rules, fn r -> r == {a, b} end) do
        true
      else
        false
      end
    end)
  end

  @spec middle_value(update()) :: integer()
  defp middle_value(update) do
    mid = div(length(update), 2)
    Enum.at(update, mid)
  end
end
