defmodule Main do
  def start(_types, _args) do
    Advent.eval()
    |> IO.inspect()

    exit(:normal)
  end
end
