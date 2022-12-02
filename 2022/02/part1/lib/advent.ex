defmodule Advent do
  @moduledoc false

  @score %{
    "A" => 1,
    "B" => 2,
    "C" => 3,
    "X" => 1,
    "Y" => 2,
    "Z" => 3
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

  defp score_round([them, us]) do
    case round(them, us) do
      :win -> @score[us] + 6
      :lose -> @score[us]
      :tie -> @score[us] + 3
    end
  end

  defp round("A", "X"), do: :tie
  defp round("A", "Y"), do: :win
  defp round("A", "Z"), do: :lose
  defp round("B", "X"), do: :lose
  defp round("B", "Y"), do: :tie
  defp round("B", "Z"), do: :win
  defp round("C", "X"), do: :win
  defp round("C", "Y"), do: :lose
  defp round("C", "Z"), do: :tie
end
