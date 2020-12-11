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
  Returns Keyword List of instructions.

  ## Examples

    iex> Advent.Input.parse(["nop +0", "acc +1", "jmp +1", "acc +2", "jmp -4"])
    [nop: 0, acc: 1, jmp: 1, acc: 2, jmp: -4]

  """
  @spec parse(List.t()) :: Keyword.t()
  def parse(instructions \\ read()) do
    regex = ~r/(\w+) ([\+\-])(\d+)/
    Enum.map(instructions, fn inst ->
      [_, op, sign, value] = Regex.run(regex, inst)

      op = String.to_atom(op)
      value = String.to_integer(value)
      value = if sign == "-", do: value * -1, else: value

      {op, value}
    end)
  end
end
