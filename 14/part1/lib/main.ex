defmodule Main do
  use Application

  def start(_types, _args) do
    Advent.eval(540391)
    |> IO.inspect

    exit :normal
  end
end
