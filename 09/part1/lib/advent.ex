defmodule Advent do

  defmodule Circle do
    defstruct board: [0], current: 0

    def next_index(circle) do
      l = length(circle.board)
      n = circle.current + 2
      if n > l, do: n - l, else: n
    end

    def back_seven(circle) do
      l = length(circle.board)
      n = circle.current - 7
      if n < 0, do: n + l, else: n
    end

  end

  defmodule Player do
    defstruct [:number, score: 0]
  end

  def play(circle, players, pi, marble) do
    if Integer.mod(marble, 23) == 0 do
      p = Enum.at(players, pi)
      ni = Circle.back_seven(circle)

      {
        %Circle{ board: List.delete_at(circle.board, ni), current: ni },
        List.replace_at(players, pi,
          %Player{ p | score: p.score + marble + Enum.at(circle.board, ni) })
      }
    else
      ni = Circle.next_index(circle)

      {
        %Circle{ board: List.insert_at(circle.board, ni, marble), current: ni }, 
        players
      }
    end
  end

  def eval(players, marbles) do
    circle = %Circle{}
    ps = for n <- 1..players, do: %Player{number: n}

    {circle, ps} = Enum.reduce(1..marbles, {circle, ps}, fn m, {c,ps} ->
      play(c, ps, Integer.mod(m - 1, players), m)
    end)

    hd(Enum.sort(ps, &(&1.score > &2.score))).score
  end

end
