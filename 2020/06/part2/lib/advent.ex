defmodule Advent do
  @moduledoc false

  @doc """
  Return count of yes answers.
  """
  @spec eval(List.t()) :: integer()
  def eval(answers \\ Advent.Input.parse()) do
    Enum.map(answers, &length/1) |> Enum.sum()
  end
end
