defmodule Advent do
  alias Advent.Board

  @spec eval(List.t()) :: Integer.t()
  def eval({turns, boards} \\ Advent.Input.parse()) do
    {last, called} = Enum.reduce_while(turns, boards, &turn/2)

    called * Advent.Board.sum_of_unmarked(last)
  end

  def turn(called, [b]) do
    b = Board.turn(b, called)
    if Board.wins?(b) do
      {:halt, {b, called}}
    else
      {:cont, [b]}
    end
  end

  def turn(called, [_|_] = boards) do
    played = Enum.map(boards, &Board.turn(&1, called))
    {:cont, Enum.filter(played, fn b -> !Board.wins?(b) end)}
  end
end
