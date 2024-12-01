defmodule Advent do
  @moduledoc false

  defmodule Almanac do
    defmodule Mapping do
      defstruct [
        :destination_start,
        :source_start,
        :range
      ]

      @type t :: %__MODULE__{
              destination_start: integer(),
              source_start: integer(),
              range: integer()
            }

      @spec new(integer(), integer(), integer()) :: t()
      def new(ds, ss, r) do
        %__MODULE__{
          destination_start: ds,
          source_start: ss,
          range: r
        }
      end

      @spec map(t(), integer()) :: {boolean(), integer()}
      def map(
            %__MODULE__{
              destination_start: ds,
              source_start: ss,
              range: r
            },
            n
          ) do
        source_max = ss + r - 1

        if n >= ss and n <= source_max do
          {true, ds + (n - ss)}
        else
          {false, n}
        end
      end
    end

    defstruct mapping: nil,
              mappings: %{},
              seeds: []

    @type t :: %__MODULE__{
            mapping: nil | {atom(), atom()},
            mappings: %{
              {atom(), atom()} => [Almanac.Map.t()]
            },
            seeds: [integer()]
          }

    @spec new([String.t()]) :: t()
    def new(lines) do
      Enum.reduce(lines, %__MODULE__{}, &parse_line/2)
    end

    defp parse_line("seeds: " <> seeds, %__MODULE__{} = almanac) do
      seeds =
        seeds
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)

      %__MODULE__{almanac | seeds: seeds}
    end

    defp parse_line(line, %__MODULE__{mapping: key} = almanac) do
      case Regex.run(~r/(\w+)-to-(\w+) map:/, line) do
        [_, a, b] ->
          key = {String.to_atom(a), String.to_atom(b)}
          mappings = Map.put(almanac.mappings, key, [])
          %__MODULE__{almanac | mapping: key, mappings: mappings}

        nil ->
          case String.split(line, " ", trim: true) do
            [_ds, _ss, _r] = args ->
              mapping = apply(Almanac.Mapping, :new, Enum.map(args, &String.to_integer/1))
              mappings = Map.put(almanac.mappings, key, [mapping | almanac.mappings[key]])

              %__MODULE__{almanac | mappings: mappings}

            _ ->
              raise "unknown line mapping #{inspect(key)}: '#{line}'"
          end
      end
    end

    @spec map(t(), {atom(), integer()}) :: {atom(), integer()}
    def map(%__MODULE__{mappings: mappings}, {from, n}) do
      {{_from, to}, maps} = Enum.find(mappings, fn {{f, _t}, _ms} -> f == from end)

      Enum.reduce_while(maps, {to, n}, fn m, {to, n} ->
        case Mapping.map(m, n) do
          {true, nn} ->
            {:halt, {to, nn}}

          {false, nn} when nn == n ->
            {:cont, {to, n}}

          _ ->
            raise "ruh roh"
        end
      end)
    end
  end

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> lowest_location()
  end

  @doc """
  """
  @spec lowest_location([String.t()]) :: integer()
  def lowest_location(list) do
    list
    |> Almanac.new()
    |> map_seeds_to_locations()
    |> Enum.min()
  end

  @spec map_seeds_to_locations(Almanac.t()) :: [integer()]
  def map_seeds_to_locations(%Almanac{} = almanac) do
    Enum.map(almanac.seeds, &thing_to_location(almanac, {:seed, &1}))
  end

  defp thing_to_location(%Almanac{} = almanac, thing_value) do
    case Almanac.map(almanac, thing_value) do
      {:location, value} ->
        value

      to_value ->
        thing_to_location(almanac, to_value)
    end
  end
end
