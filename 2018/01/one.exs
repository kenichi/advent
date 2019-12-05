#!/usr/bin/env elixir

IO.puts IO.read(:stdio, :all)
        |> String.split("\n")
        |> Enum.map(&String.trim(&1))
        |> Enum.reject(&(String.length(&1) == 0))
        |> Enum.map(&String.to_integer(&1))
        |> Enum.reduce(0, fn n, acc -> acc + n end)
