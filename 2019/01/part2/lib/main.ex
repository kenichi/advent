defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.eval()

    exit(:normal)
  end
end
