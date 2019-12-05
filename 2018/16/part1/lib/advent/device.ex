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
end
