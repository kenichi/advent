defmodule Advent do
  @moduledoc false

  @blinks 25

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> stone_count(@blinks)
  end

  @doc """
  Process the stones for the number of blinks and count.
  """
  @spec stone_count([integer()], integer()) :: integer()
  def stone_count(stones, blinks) do
    new_stones =
      Enum.reduce(1..blinks, stones, fn _, stones ->
        stones
        |> blink()
        |> Enum.reverse()
      end)

    length(new_stones)
  end

  @spec blink([integer()]) :: [integer()]
  defp blink(stones) do
    Enum.reduce(stones, [], fn
      0, ns ->
        [1 | ns]

      s, ns ->
        s_str = to_string(s)
        s_str_len = String.length(s_str)

        if rem(s_str_len, 2) == 0 do
          [a, b] =
            s_str
            |> String.split_at(div(s_str_len, 2))
            |> Tuple.to_list()
            |> Enum.map(&String.to_integer/1)

          [a, b | ns]
        else
          [s * 2024 | ns]
        end
    end)
  end
end
