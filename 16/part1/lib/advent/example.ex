defmodule Advent.Example do
  defstruct before: {0, 0, 0, 0},
            after: {0, 0, 0, 0},
            attrs: [0, 0, 0, 0]

  alias Advent.Device

  @ops [
    &Device.addr/4,
    &Device.addi/4,
    # ---
    &Device.mulr/4,
    &Device.muli/4,
    # ---
    &Device.banr/4,
    &Device.bani/4,
    # ---
    &Device.borr/4,
    &Device.bori/4,
    # ---
    &Device.setr/4,
    &Device.seti/4,
    # ---
    &Device.gtir/4,
    &Device.gtri/4,
    &Device.gtrr/4,
    # ---
    &Device.eqir/4,
    &Device.eqri/4,
    &Device.eqrr/4
  ]

  def filter_ops(example) do
    Enum.filter(@ops, &test_op(example, &1))
  end

  def test_op(example, op) do
    [_, a, b, c] = example.attrs
    apply(op, [example.before, a, b, c]) == example.after
  end
end
