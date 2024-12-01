defmodule Advent do
  @moduledoc false

  defmodule Part do
    defstruct adjacent: false, complete: false, number: nil
  end

  defmodule Schematic do
    defstruct lines: [], max_x: nil, max_y: nil, part: nil, parts: 0, point: nil

    def eol?(%__MODULE__{max_x: mx, point: {x, _}}) when mx == x, do: true
    def eol?(%__MODULE__{}), do: false

    def new(lines) do
      max_x = String.length(hd(lines)) - 1
      max_y = length(lines) - 1

      %__MODULE__{
        lines: lines,
        max_x: max_x,
        max_y: max_y
      }
    end

    def put_point(%__MODULE__{} = schematic, point),
      do: %__MODULE__{schematic | point: point}
  end

  @number ~r/\d/
  @symbol ~r/[^\d\.]/

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> part_numbers_sum()
  end

  @doc """
  Find the part numbers and sum.
  """
  @spec part_numbers_sum([String.t()]) :: integer()
  def part_numbers_sum(list) do
    schematic = parse_schematic(list)
    schematic.parts
  end

  def parse_schematic(lines) do
    schematic = Schematic.new(lines)

    Enum.reduce(0..schematic.max_y, schematic, fn y, schematic ->
      Enum.reduce(0..schematic.max_x, schematic, fn x, schematic ->
        schematic
        |> Schematic.put_point({x, y})
        |> update_part()
        |> update_parts()
      end)
    end)
  end

  defp char_at(lines, {x, y}) do
    lines
    |> Enum.at(y)
    |> String.at(x)
  end

  defp update_part(schematic) do
    char = char_at(schematic.lines, schematic.point)

    part =
      if Regex.match?(@number, char) do
        if is_nil(schematic.part) do
          %Part{
            adjacent: is_adjacent?(schematic),
            complete: Schematic.eol?(schematic),
            number: char
          }
        else
          %Part{
            adjacent: is_adjacent?(schematic),
            complete: Schematic.eol?(schematic),
            number: schematic.part.number <> char
          }
        end
      else
        if is_nil(schematic.part) do
          nil
        else
          %Part{schematic.part | complete: true}
        end
      end

    %Schematic{schematic | part: part}
  end

  defp is_adjacent?(%Schematic{part: %Part{adjacent: true}}), do: true

  defp is_adjacent?(schematic) do
    schematic.point
    |> surrounding()
    |> filter_existing(schematic)
    |> any_symbols?(schematic.lines)
  end

  defp surrounding({x, y}) do
    [
      {x - 1, y},
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
      {x, y + 1},
      {x - 1, y + 1}
    ]
  end

  defp filter_existing(points, %Schematic{max_x: mx, max_y: my}) do
    Enum.filter(points, fn {x, y} ->
      x >= 0 && x <= mx && y >= 0 && y <= my
    end)
  end

  defp any_symbols?(points, lines),
    do: Enum.any?(points, &Regex.match?(@symbol, char_at(lines, &1)))

  defp update_parts(%Schematic{part: %Part{complete: true} = part} = schematic) do
    if part.adjacent do
      {n, _} = Integer.parse(part.number)
      %Schematic{schematic | part: nil, parts: schematic.parts + n}
    else
      %Schematic{schematic | part: nil}
    end
  end

  defp update_parts(%Schematic{} = schematic), do: schematic
end
