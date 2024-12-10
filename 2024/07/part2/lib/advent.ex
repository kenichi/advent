defmodule Advent do
  @moduledoc false

  @type operator :: :+ | :* | :|| | :halt

  @operators [:+, :*, :||]

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> calibration_result()
  end

  @doc """
  Sum values of possibly true calibrations.
  """
  @spec calibration_result([{integer(), [integer()]}]) :: integer()
  def calibration_result(advent) do
    advent
    |> Enum.map(&value_if_true/1)
    |> Task.await_many(:infinity)
    |> Enum.sum()
  end

  @spec value_if_true({integer(), [integer()]}) :: Task.t()
  defp value_if_true({value, numbers}) do
    Task.async(fn ->
      numbers
      |> permutations()
      |> Enum.any?(fn perm -> eval_numbers(perm) == value end)
      |> if(do: value, else: 0)
    end)
  end

  @spec permutations([integer()]) :: [[{integer(), operator()}]]
  def permutations(numbers) do
    count = length(numbers) - 1
    ops = permutations_of(@operators, count)

    Enum.map(ops, &Enum.zip(numbers, &1 ++ [:halt]))
  end

  @spec eval_numbers([{integer(), operator()}]) :: integer()
  def eval_numbers([hd_num_op | tl_num_ops]) do
    {value, :halt} =
      Enum.reduce(tl_num_ops, hd_num_op, fn {b, new_op}, {a, op} ->
        new_value = operate(op, a, b)
        {new_value, new_op}
      end)

    value
  end

  @spec operate(operator(), integer(), integer()) :: integer()
  defp operate(:+, a, b), do: a + b

  defp operate(:*, a, b), do: a * b

  defp operate(:||, a, b), do: String.to_integer("#{a}#{b}")

  @spec permutations_of(list(), integer()) :: [list()]
  def permutations_of(list, count) do
    list
    |> permutations_of(count, [])
    |> flatten()
  end

  defp permutations_of(_list, 0, ret), do: ret

  defp permutations_of(list, n, ret) do
    for x <- list do
      permutations_of(list, n - 1, [x | ret])
    end
  end

  @spec flatten(list()) :: list()
  def flatten(list) do
    flatten(list, [])
  end

  defp flatten(list, flat) do
    Enum.reduce(list, flat, fn e, f ->
      if is_list(e) and is_list(hd(e)) do
        flatten(e, f)
      else
        [e | f]
      end
    end)
  end
end
