defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> render_screen()
    |> IO.puts()
  end

  def render_screen(input) do
    {_cycle, _x, lines} =
      input
      |> Enum.reduce({0, 1, [[]]}, &reduce_instructions/2)
      |> handle_line(0, false)

    lines
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp reduce_instructions(inst, state) do
    state
    |> cycle(inst)
    |> perform(inst)
  end

  defp cycle(state, "addx" <> _) do
    state
    |> next_cycle()
    |> next_cycle()
  end

  defp cycle(state, "noop"), do: next_cycle(state)

  defp next_cycle(state) do
    state
    |> increment_cycle()
    |> build_line()
  end

  defp increment_cycle({cycle, x, lines}), do: {cycle + 1, x, lines}

  defp build_line({cycle, _x, _lines} = state) do
    mod = Integer.mod(cycle - 1, 40)

    state
    |> handle_line(mod)
    |> draw_pixel(mod)
  end

  defp handle_line({cycle, x, [line | rest] = lines}, mod, begin \\ true) do
    if cycle > 1 && mod == 0 do
      line =
        line
        |> Enum.reverse()
        |> Enum.join("")

      lines = if begin, do: [[] | [line | rest]], else: [line | rest]

      {cycle, x, lines}
    else
      {cycle, x, lines}
    end
  end

  defp draw_pixel({cycle, x, [line | rest]}, mod) do
    lines =
      if mod in sprite(x) do
        [["#" | line] | rest]
      else
        [["." | line] | rest]
      end

    {cycle, x, lines}
  end

  defp sprite(x), do: [x - 1, x, x + 1]

  defp perform({cycle, x, lines}, "addx " <> n), do: {cycle, x + String.to_integer(n), lines}

  defp perform(state, "noop"), do: state
end
