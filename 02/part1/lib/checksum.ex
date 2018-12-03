defmodule Checksum do
  use Application

  def start(_types, _args) do
    IO.puts Advent.read_input
            |> Advent.checksum

    exit(:normal)
  end
end
