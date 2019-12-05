defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.eval(429, 7090100)
    |> IO.puts

    exit :normal
  end
end
