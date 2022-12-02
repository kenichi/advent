defmodule Advent do
  @moduledoc false

  @score %{
    "A" => 1,
    "B" => 2,
    "C" => 3
  }

  @result %{
    "X" => :lose,
    "Y" => :tie,
    "Z" => :win
  }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> calculate_score()
  end

  @doc """
  Walk the "strategy" list, compute scores for rounds, and sum.
  """
  def calculate_score(list) do
    list
    |> Enum.map(&split_and_score/1)
    |> Enum.sum()
  end

  defp split_and_score(line) do
    line
    |> String.split(" ")
    |> score_round()
  end

  defp score_round([them, result]) do
    case @result[result] do
      :win -> @score[win(them)] + 6
      :lose -> @score[lose(them)]
      :tie -> @score[tie(them)] + 3
    end
  end

  defp win("A"), do: "B"
  defp win("B"), do: "C"
  defp win("C"), do: "A"
  defp lose("A"), do: "C"
  defp lose("B"), do: "A"
  defp lose("C"), do: "B"
  defp tie("A"), do: "A"
  defp tie("B"), do: "B"
  defp tie("C"), do: "C"
end
