defmodule Advent.Input do
  @moduledoc """
  """

  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  @doc """
  Returns bag rules.

  ## Examples

    iex> Advent.Input.parse(["light red bags contain 1 bright white bag, 2 muted yellow bags.", "dark orange bags contain 3 bright white bags, 4 muted yellow bags.", "dotted black bags contain no other bags."])
    %{
      light_red: [{:bright_white, 1}, {:muted_yellow, 2}],
      dark_orange: [{:bright_white, 3}, {:muted_yellow, 4}],
      dotted_black: nil
    }

  """
  @spec parse(List.t()) :: Map.t()
  def parse(forms \\ read()) do
    Enum.reduce(forms, %{}, fn form, map ->
      String.split(form, " bags contain ", trim: true)
      |> (fn [color, contents] ->
            color =
              color
              |> String.replace(" ", "_")
              |> String.to_atom()

            contents =
              case contents do
                "no other bags." ->
                  nil

                _ ->
                  contents
                  |> String.split(",", trim: true)
                  |> Enum.map(&parse_content/1)
              end

            Map.put(map, color, contents)
          end).()
    end)
  end

  defp parse_content(content) do
    Regex.run(~r/(\d+) (\w+ \w+) bag/, content)
    |> (fn [_, quantity, color] ->
          quantity = quantity |> String.to_integer()

          color =
            color
            |> String.replace(" ", "_")
            |> String.to_atom()

          {color, quantity}
        end).()
  end

  def test_input() do
    """
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
    """
  end
end
