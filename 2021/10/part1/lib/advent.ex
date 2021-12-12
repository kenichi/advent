defmodule Advent do
  @points %{
    p: 3,
    s: 57,
    c: 1197,
    a: 25137
  }

  def eval(lines \\ Advent.Input.parse()) do
    Enum.reduce(lines, {[], []}, &parse_chunks/2)
    |> elem(1)
    |> Enum.reduce(0, fn e, s -> @points[e] + s end)
  end

  def parse_chunks(line, state) do
    Enum.reduce_while(line, state, &parse_chunk/2)
  end

  def parse_chunk("<", state), do: open(:a, state)
  def parse_chunk(">", state), do: close(:a, state)

  def parse_chunk("{", state), do: open(:c, state)
  def parse_chunk("}", state), do: close(:c, state)

  def parse_chunk("(", state), do: open(:p, state)
  def parse_chunk(")", state), do: close(:p, state)

  def parse_chunk("[", state), do: open(:s, state)
  def parse_chunk("]", state), do: close(:s, state)

  def open(chtype, {stack, errors}) do
    {:cont, {[chtype | stack], errors}}
  end

  def close(chtype, {[closed | rest], errors}) when chtype == closed do
    {:cont, {rest, errors}}
  end

  def close(chtype, {stack, errors}) do
    {
      :halt,
      {
        stack,
        [chtype | errors]
      }
    }
  end
end
