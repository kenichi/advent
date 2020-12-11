defmodule Advent do
  @moduledoc false

  @type state :: {integer(), integer(), MapSet.t()}

  @doc """
  Test flipping each :jmp and :nop until program ends successfully. Return
  value in accumulator.
  """
  @spec eval(Keyword.t()) :: integer()
  def eval(instructions \\ Advent.Input.parse()) do
    range = 0..length(instructions)
    filter = fn i ->
      case Enum.at(instructions, i) do
        {:jmp, _} -> true
        {:nop, _} -> true
        _ -> false
      end
    end
    indices = for i <- range, filter.(i), do: i

    Enum.reduce_while(indices, -1, fn i, _ ->
      instructions
      |> flip_op(i)
      |> boot()
    end)
  end

  defp flip_op(is, i) do
    new_op =
      case Enum.at(is, i) do
        {:jmp, n} -> {:nop, n}
        {:nop, n} -> {:jmp, n}
        _ -> raise ArgumentError
      end

    List.replace_at(is, i, new_op)
  end

  @doc """
  Run program, starting with acc of 0, keeping history of pointer values. If
  a repeat is detected, break and return the accumulated value. Otherwise,
  continue until end of program is reached.

  ## Examples
  
    iex> Advent.boot([nop: 0, acc: 1])
    {:halt, 1}

    iex> Advent.boot([nop: 0, jmp: -1])
    {:cont, 0}

  """
  @spec eval(Keyword.t()) :: integer()
  def boot(instructions, state \\ {0, 0, MapSet.new()}) do
    {a, p, h} = run(instructions, state)
    if p == length(instructions) do
      {:halt, a}
    else
      if MapSet.member?(h, p) do
        {:cont, a}
      else
        boot(instructions, {a, p, h})
      end
    end
  end

  @spec run(Keyword.t(), state) :: state
  defp run(instructions, {acc, pointer, history}) do
    history = MapSet.put(history, pointer)

    case Enum.at(instructions, pointer) do
      {:nop, _} ->
        {acc, pointer + 1, history}

      {:acc, val} ->
        {acc + val, pointer + 1, history}

      {:jmp, val} ->
        {acc, pointer + val, history}
    end
  end
end
