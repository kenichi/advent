defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"
  @file_regex ~r/^(\d+) (\S+)$/

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], %{}}, &reduce_line/2)
    |> elem(1)
  end

  defp reduce_line("$ cd /", {_dirs, tree}), do: {[], tree}

  defp reduce_line("$ cd ..", {dirs, tree}), do: {tl(dirs), tree}

  defp reduce_line("$ cd " <> dir, {dirs, tree}), do: {[dir | dirs], tree}

  defp reduce_line("$ ls", {dirs, tree}), do: {dirs, tree}

  defp reduce_line("dir " <> dir, {dirs, tree}) do
    {
      dirs,
      put_in(tree, Enum.reverse(dirs) ++ [dir], %{})
    }
  end

  defp reduce_line(file, {dirs, tree}) do
    [_match, size, name] = Regex.run(@file_regex, file)

    {
      dirs,
      put_in(tree, Enum.reverse(dirs) ++ [name], String.to_integer(size))
    }
  end
end
