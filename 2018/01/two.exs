#!/usr/bin/env elixir

defmodule Two do
  defstruct found: false, freq: 0, set: MapSet.new(), steps: nil, times: 0

  def find_first_repeat two do
    # IO.puts "times: #{two.times} - #{two.freq} - #{MapSet.size(two.set)}"

    two = Enum.reduce_while two.steps, two, fn n, t ->
      case Two.do_step t, n do
        {:halt, f} -> {:halt, %Two{t | freq: f, found: true}}
        {:cont, f} -> {:cont, %Two{t | freq: f, set: MapSet.put(t.set, f)}}
      end
    end

    # IO.puts "times: #{two.times} - #{two.freq} - #{MapSet.size(two.set)}"

    if two.found do
      IO.puts "first repeat freq: #{two.freq}"
    else
      # unless two.times > 5 do
        Two.find_first_repeat %Two{two | times: two.times + 1}
      # end
    end
  end

  def do_step two, inst do
    f = two.freq + inst
    if MapSet.member? two.set, f do
      {:halt, f}
    else
      {:cont, f}
    end
  end

end

defmodule Main do
  def main do
    steps = IO.read(:stdio, :all)
            |> String.split("\n")
            |> Enum.map(&String.trim(&1))
            |> Enum.reject(&(String.length(&1) == 0))
            |> Enum.map(&String.to_integer(&1))

    %Two{steps: steps}
    |> Two.find_first_repeat
  end
end
Main.main
