defmodule Advent do
  def eval(lines \\ Advent.Input.parse()) do
    scores =
      Enum.reduce(lines, [], &parse_chunks/2)
      |> Enum.sort()

    Enum.at(scores, div(length(scores), 2))
  end

  def parse_chunks(line, scores) do
    case Enum.reduce_while(line, {[], nil}, &parse_chunk/2) do
      {stack, nil} -> [points(stack) | scores]
      {_, _} -> scores
    end
  end

  def points(incomplete, p \\ 0)
  def points([], p), do: p
  def points([chtype | rest], p) do
    p = p * 5

    n =
      case chtype do
        :a -> 4
        :c -> 3
        :p -> 1
        :s -> 2
      end

    points(rest, p + n)
  end

  def parse_chunk("<", state), do: open(:a, state)
  def parse_chunk(">", state), do: close(:a, state)

  def parse_chunk("{", state), do: open(:c, state)
  def parse_chunk("}", state), do: close(:c, state)

  def parse_chunk("(", state), do: open(:p, state)
  def parse_chunk(")", state), do: close(:p, state)

  def parse_chunk("[", state), do: open(:s, state)
  def parse_chunk("]", state), do: close(:s, state)

  def open(chtype, {stack, error}) do
    {:cont, {[chtype | stack], error}}
  end

  def close(chtype, {[closed | rest], error}) when chtype == closed do
    {:cont, {rest, error}}
  end

  def close(chtype, {stack, _error}) do
    {:halt, {stack, chtype}}
  end
end
