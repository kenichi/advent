defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.read_input
    |> Advent.parse_input
    |> Advent.sort_input
    |> Advent.build_guards
    |> Advent.id_times_minute
    |> IO.puts

    exit :normal
  end
end
