defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.read_input
    |> Advent.eval
    |> IO.puts

    exit :normal
  end
end
