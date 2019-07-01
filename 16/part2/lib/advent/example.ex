defmodule Advent.Example do
  defstruct before: {0, 0, 0, 0},
            after: {0, 0, 0, 0},
            attrs: [0, 0, 0, 0]

  alias Advent.Device

  def filter_ops(%__MODULE__{} = example) do
    Enum.filter(Device.ops(), &test_op(example, &1))
  end

  def test_op(%__MODULE__{} = example, op) do
    [_, a, b, c] = example.attrs
    apply(op, [example.before, a, b, c]) == example.after
  end

  def opcode(%__MODULE__{} = example) do
    hd(example.attrs)
  end
end
