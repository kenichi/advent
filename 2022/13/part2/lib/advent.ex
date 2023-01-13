defmodule Advent do
  @moduledoc false

  @div_a [[2]]
  @div_b [[6]]
  @divs [@div_a, @div_b]

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> ordered_packets_divider_index_product()
  end

  def ordered_packets_divider_index_product(packets) do
    packets
    |> append_divider_packets()
    |> Enum.sort(&sorter/2)
    |> Enum.with_index(1)
    |> divider_indices()
    |> Enum.product()
  end

  defp append_divider_packets(packets), do: packets ++ @divs

  defp sorter(left, right) do
    cond do
      is_integer(left) and not is_integer(right) ->
        sorter([left], right)

      not is_integer(left) and is_integer(right) ->
        sorter(left, [right])

      is_list(left) and is_list(right) ->
        case {left, right} do
          {[], [_ | _]} ->
            true

          {[_ | _], []} ->
            false

          {[_ | _], [_ | _]} ->
            compare_lists(left, right)

          {[], []} ->
            nil
        end

      is_integer(left) and is_integer(right) and left != right ->
        left < right

      is_integer(left) and is_integer(right) and left == right ->
        nil
    end
  end

  defp compare_lists([l | l_tl], [r | r_tl]) do
    result = sorter(l, r)
    if is_nil(result), do: sorter(l_tl, r_tl), else: result
  end

  defp divider_indices(list), do: [index_of(list, @div_a), index_of(list, @div_b)]

  defp index_of(list, element) do
    list
    |> Enum.find(fn {v, _} -> v == element end)
    |> elem(1)
  end
end
