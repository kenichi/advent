defmodule Advent do
  @moduledoc false

  defmodule Part do
    defstruct complete: false, coordinates: [], number: nil
  end

  defmodule Schematic do
    defstruct lines: [], gears: [], max_x: nil, max_y: nil, part: nil, parts: [], point: nil

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

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> gear_ratios_sum()
  end

  @doc """
  Find the gear ratios and sum.
  """
  @spec gear_ratios_sum([String.t()]) :: integer()
  def gear_ratios_sum(list) do
    list
    |> parse_schematic()
    |> find_sum()
  end

  def parse_schematic(lines) do
    schematic = Schematic.new(lines)

    Enum.reduce(0..schematic.max_y, schematic, fn y, schematic ->
      Enum.reduce(0..schematic.max_x, schematic, fn x, schematic ->
        schematic
        |> Schematic.put_point({x, y})
        |> update_gears_part()
        |> update_parts()
      end)
    end)
  end

  defp find_sum(%Schematic{} = schematic) do
    Enum.reduce(schematic.gears, 0, fn gear, sum ->
      case two_parts(schematic, gear) do
        [a, b] ->
          sum + (a.number * b.number)

        _ ->
          sum
      end
    end)
  end

  defp two_parts(%Schematic{} = schematic, gear) do
    surround = surrounding(gear)

    Enum.filter(schematic.parts, fn %Part{coordinates: coords} ->
      Enum.any?(surround, & &1 in coords)
    end)
  end

  defp char_at(lines, {x, y}) do
    lines
    |> Enum.at(y)
    |> String.at(x)
  end

  defp update_gears_part(schematic) do
    char = char_at(schematic.lines, schematic.point)

    part =
      if Regex.match?(@number, char) do
          if is_nil(schematic.part) do
            %Part{
              complete: Schematic.eol?(schematic),
              coordinates: [schematic.point],
              number: char
            }
          else
            %Part{
              complete: Schematic.eol?(schematic),
              coordinates: [schematic.point | schematic.part.coordinates],
              number: schematic.part.number <> char
            }
          end
      else
        if is_nil(schematic.part) do
          nil
        else
          coordinates = Enum.reverse(schematic.part.coordinates)
          %Part{schematic.part | complete: true, coordinates: coordinates}
        end
      end

    gears =
      if char == "*" do
        [schematic.point | schematic.gears]
      else
        schematic.gears
      end

    %Schematic{schematic | gears: gears, part: part}
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

  defp update_parts(%Schematic{part: %Part{complete: true} = part} = schematic) do
    {n, _} = Integer.parse(part.number)
    part = %Part{part | number: n}
    %Schematic{schematic | part: nil, parts: [part | schematic.parts]}
  end

  defp update_parts(%Schematic{} = schematic), do: schematic
end
