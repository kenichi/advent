defmodule Common do
  use Application

  def start(_types, _args) do
    IO.puts Advent.read_input
            |> Advent.common

    exit(:normal)
  end
end
