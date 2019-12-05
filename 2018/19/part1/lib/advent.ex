defmodule Advent do
  alias Advent.Device

  defstruct registers: {0, 0, 0, 0, 0, 0},
            instructions: [],
            ip: 0

  def read_input(file) do
    File.stream!(file)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.reduce(%Advent{}, &parse/2)
    |> reverse_insts()
  end

  def parse(line, state) do
    if String.starts_with?(line, "#ip ") do
      %Advent{state | ip: parse_ip(line)}
    else
      %Advent{state | instructions: [parse_inst(line) | state.instructions]}
    end
  end

  def parse_ip(line) do
    String.at(line, 4) |> String.to_integer()
  end

  def parse_inst(line) do
    String.split(line)
    |> List.to_tuple()
    |> convert_inst()
  end

  defp convert_inst({i, a, b, c}) do
    {
      String.to_atom(i),
      String.to_integer(a),
      String.to_integer(b),
      String.to_integer(c)
    }
  end

  def reverse_insts(%Advent{instructions: is} = state) do
    %Advent{state | instructions: Enum.reverse(is)}
  end

  def incr({:halt, s}), do: s
  def incr({:cont, s}), do: incr(s)
  def incr(%Advent{ip: ip} = state) do
    Device.put_register(state, ip, Device.register(state, ip) + 1)
  end

  def inst(%Advent{instructions: is, ip: ip} = s) do
    v = Device.register(s, ip)
    if v < 0 do
      nil
    else
      Enum.at(is, Device.register(s, ip))
    end
  end

  def exec(%Advent{} = state, nil) do
    {:halt, state}
  end

  def exec(%Advent{} = state, {inst, a, b, c}) do
    { :cont,
      apply(Advent.Device, inst, [state, a, b, c])
    }
  end

  def exec(%Advent{} = state) do
    case exec(state, inst(state)) do
      {:cont, s} -> incr(s) |> exec()
      {:halt, s} -> s
    end
  end

  def eval(file \\ "input/input.txt") do
    read_input(file)
    |> exec()
    |> (fn %Advent{registers: rs} -> elem(rs, 0) end).()
  end
end
