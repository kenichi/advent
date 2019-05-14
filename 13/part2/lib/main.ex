defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.eval
    |> IO.inspect

    exit :normal
  end
end
