defmodule Advent.Device do
  use Bitwise

  # ---

  def addr(d, a, b, c) do
    put_elem(d, c, elem(d, a) + elem(d, b))
  end

  def addi(d, a, b, c) do
    put_elem(d, c, elem(d, a) + b)
  end

  # ---

  def mulr(d, a, b, c) do
    put_elem(d, c, elem(d, a) * elem(d, b))
  end

  def muli(d, a, b, c) do
    put_elem(d, c, elem(d, a) * b)
  end

  # ---

  def banr(d, a, b, c) do
    put_elem(d, c, elem(d, a) &&& elem(d, b))
  end

  def bani(d, a, b, c) do
    put_elem(d, c, elem(d, a) &&& b)
  end

  # ---

  def borr(d, a, b, c) do
    put_elem(d, c, elem(d, a) ||| elem(d, b))
  end

  def bori(d, a, b, c) do
    put_elem(d, c, elem(d, a) ||| b)
  end

  # ---

  def setr(d, a, _, c) do
    put_elem(d, c, elem(d, a))
  end

  def seti(d, a, _, c) do
    put_elem(d, c, a)
  end

  # ---

  def gtir(d, a, b, c) do
    put_elem(d, c, if(a > elem(d, b), do: 1, else: 0))
  end

  def gtri(d, a, b, c) do
    put_elem(d, c, if(elem(d, a) > b, do: 1, else: 0))
  end

  def gtrr(d, a, b, c) do
    put_elem(d, c, if(elem(d, a) > elem(d, b), do: 1, else: 0))
  end

  # ---

  def eqir(d, a, b, c) do
    put_elem(d, c, if(a == elem(d, b), do: 1, else: 0))
  end

  def eqri(d, a, b, c) do
    put_elem(d, c, if(elem(d, a) == b, do: 1, else: 0))
  end

  def eqrr(d, a, b, c) do
    put_elem(d, c, if(elem(d, a) == elem(d, b), do: 1, else: 0))
  end

  # ---

  @ops [
    &Advent.Device.addr/4,
    &Advent.Device.addi/4,
    # ---
    &Advent.Device.mulr/4,
    &Advent.Device.muli/4,
    # ---
    &Advent.Device.banr/4,
    &Advent.Device.bani/4,
    # ---
    &Advent.Device.borr/4,
    &Advent.Device.bori/4,
    # ---
    &Advent.Device.setr/4,
    &Advent.Device.seti/4,
    # ---
    &Advent.Device.gtir/4,
    &Advent.Device.gtri/4,
    &Advent.Device.gtrr/4,
    # ---
    &Advent.Device.eqir/4,
    &Advent.Device.eqri/4,
    &Advent.Device.eqrr/4
  ]

  def ops(), do: @ops
end
