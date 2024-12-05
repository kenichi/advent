defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.t()
  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%Advent{}, &reduce_line/2)
  end

  @spec reduce_line(String.t(), Advent.t()) :: Advent.t()
  defp reduce_line(line, %Advent{} = advent) do
    cond do
      String.contains?(line, "|") ->
        rule =
          line
          |> String.split("|", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()

        %Advent{advent | rules: [rule | advent.rules]}

      String.contains?(line, ",") ->
        update =
          line
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)

        %Advent{advent | updates: [update | advent.updates]}

      line == "" ->
        advent
    end
  end
end
