defmodule Advent.Device do
  use Bitwise

  def register(%Advent{registers: rs}, idx) do
    elem(rs, idx)
  end

  def put_register(%Advent{registers: rs} = state, idx, val) do
    %Advent{state | registers: put_elem(rs, idx, val)}
  end

  # ---

  def addr(d, a, b, c) do
    put_register(d, c, register(d, a) + register(d, b))
  end

  def addi(d, a, b, c) do
    put_register(d, c, register(d, a) + b)
  end

  # ---

  def mulr(d, a, b, c) do
    put_register(d, c, register(d, a) * register(d, b))
  end

  def muli(d, a, b, c) do
    put_register(d, c, register(d, a) * b)
  end

  # ---

  def banr(d, a, b, c) do
    put_register(d, c, register(d, a) &&& register(d, b))
  end

  def bani(d, a, b, c) do
    put_register(d, c, register(d, a) &&& b)
  end

  # ---

  def borr(d, a, b, c) do
    put_register(d, c, register(d, a) ||| register(d, b))
  end

  def bori(d, a, b, c) do
    put_register(d, c, register(d, a) ||| b)
  end

  # ---

  def setr(d, a, _, c) do
    put_register(d, c, register(d, a))
  end

  def seti(d, a, _, c) do
    put_register(d, c, a)
  end

  # ---

  def gtir(d, a, b, c) do
    put_register(d, c, if(a > register(d, b), do: 1, else: 0))
  end

  def gtri(d, a, b, c) do
    put_register(d, c, if(register(d, a) > b, do: 1, else: 0))
  end

  def gtrr(d, a, b, c) do
    put_register(d, c, if(register(d, a) > register(d, b), do: 1, else: 0))
  end

  # ---

  def eqir(d, a, b, c) do
    put_register(d, c, if(a == register(d, b), do: 1, else: 0))
  end

  def eqri(d, a, b, c) do
    put_register(d, c, if(register(d, a) == b, do: 1, else: 0))
  end

  def eqrr(d, a, b, c) do
    put_register(d, c, if(register(d, a) == register(d, b), do: 1, else: 0))
  end
end
