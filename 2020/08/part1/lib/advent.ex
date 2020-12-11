defmodule Advent do
  @moduledoc false

  @type state :: {integer(), integer(), MapSet.t()}

  @doc """
  Run program, starting with acc of 0, keeping history of pointer values. Once
  a repeat is detected, break and return the accumulated value.
  """
  @spec eval(Keyword.t()) :: integer()
  def eval(instructions \\ Advent.Input.parse(), state \\ {0, 0, MapSet.new()}) do
    {a, p, h} = run(instructions, state)
    if MapSet.member?(h, p), do: a, else: eval(instructions, {a, p, h})
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
