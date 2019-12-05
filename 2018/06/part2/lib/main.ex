defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.read_input
    |> Advent.eval(10000)
    |> IO.puts

    exit :normal
  end
end
