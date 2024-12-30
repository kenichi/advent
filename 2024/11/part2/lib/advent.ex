defmodule Advent do
  @moduledoc false

  @type freqs :: %{integer() => integer()}

  @blinks 75

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
  @spec stone_count(freqs(), integer()) :: integer()
  def stone_count(freqs, blinks) do
    freqs
    |> blink(blinks)
    |> Map.values()
    |> Enum.sum()
  end

  @spec blink(freqs(), integer()) :: freqs()
  def blink(freqs, blinks) do
    Enum.reduce(1..blinks, freqs, fn _b, freqs ->
      Enum.reduce(freqs, %{}, fn {stone, count}, new_freqs ->
        case change(stone) do
          {a, b} ->
            new_freqs
            |> update_freqs(a, count)
            |> update_freqs(b, count)

          a ->
            update_freqs(new_freqs, a, count)
        end
      end)
    end)
  end

  @spec change(integer()) :: integer() | {integer(), integer()}
  defp change(0), do: 1

  defp change(s) do
    s_str = to_string(s)
    s_str_len = String.length(s_str)

    if rem(s_str_len, 2) == 0 do
      s_str
      |> String.split_at(div(s_str_len, 2))
      |> intify()
    else
      s * 2024
    end
  end

  @spec intify({String.t(), String.t()}) :: {integer(), integer()}
  defp intify({a, b}), do: {String.to_integer(a), String.to_integer(b)}

  @spec update_freqs(freqs(), integer(), integer()) :: freqs()
  defp update_freqs(freqs, stone, to_add) do
    orig = Map.get(freqs, stone, 0)

    Map.put(freqs, stone, orig + to_add)
  end
end
