defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> ordered_pair_index_sum()
  end

  def ordered_pair_index_sum(pairs) do
    pairs
    |> Enum.with_index(1)
    |> Enum.filter(&ordered_pair?/1)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp ordered_pair?({[left, right] = pair, index}) do
    cond do
      is_integer(left) and not is_integer(right) ->
        ordered_pair?({[[left], right], index})

      not is_integer(left) and is_integer(right) ->
        ordered_pair?({[left, [right]], index})

      is_list(left) and is_list(right) ->
        case {left, right} do
          {[], [_ | _]} ->
            true

          {[_ | _], []} ->
            false

          {[_ | _], [_ | _]} ->
            compare_lists(pair, index)

          {[], []} ->
            nil
        end

      is_integer(left) and is_integer(right) and left != right ->
        left < right

      is_integer(left) and is_integer(right) and left == right ->
        nil
    end
  end

  defp compare_lists([[a | a_tl], [b | b_tl]], index) do
    result = ordered_pair?({[a, b], index})

    if is_nil(result) do
      next_pair = [a_tl, b_tl]
      ordered_pair?({next_pair, index})
    else
      result
    end
  end
end
