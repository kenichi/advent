defmodule Advent do
  alias Advent.Board

  @spec eval(List.t()) :: Integer.t()
  def eval({turns, boards} \\ Advent.Input.parse()) do
    {winner, called} = Enum.reduce_while(turns, boards, &turn/2)
    called * Advent.Board.sum_of_unmarked(winner)
  end

  def turn(called, boards) do
    played = Enum.map(boards, &Board.turn(&1, called))

    case Enum.filter(played, &Board.wins?/1) do
      [winner] -> {:halt, {winner, called}}
      [] -> {:cont, played}
    end
  end
end
