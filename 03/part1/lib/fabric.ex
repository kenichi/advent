defmodule Fabric do
  use Application

  def start(_types, _args) do
    IO.puts Advent.read_input
            |> Advent.parse_input
            |> Advent.count_shared_squares

    exit :normal
  end
end
