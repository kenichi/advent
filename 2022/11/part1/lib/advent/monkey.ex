defmodule Advent.Monkey do
  defstruct [:id, :inspections, :items, :operation, :test, :success, :failure]

  defp parse_id("Monkey " <> id) do
    id
    |> String.replace_trailing(":", "")
    |> String.to_integer()
  end

  defp parse_items("  Starting items: " <> items) do
    items
    |> String.split(", ")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_operation("  Operation: new = " <> oper) do
    oper
    |> String.split(" ", trim: true)
    |> build_operation()
  end

  defp build_operation(["old", oper, "old"]) do
    fn x -> apply(Kernel, String.to_atom(oper), [x, x]) end
  end

  defp build_operation(["old", oper, val]) do
    fn x -> apply(Kernel, String.to_atom(oper), [x, String.to_integer(val)]) end
  end

  defp parse_test("  Test: divisible by " <> test) do
    String.to_integer(test)
  end

  defp parse_success("    If true: throw to monkey " <> success) do
    String.to_integer(success)
  end

  defp parse_failure("    If false: throw to monkey " <> failure) do
    String.to_integer(failure)
  end

  def parse_monkey([id, items, operation, test, success, failure]) do
    %__MODULE__{
      id: parse_id(id),
      inspections: 0,
      items: parse_items(items),
      operation: parse_operation(operation),
      test: parse_test(test),
      success: parse_success(success),
      failure: parse_failure(failure)
    }
  end

  def inspect_items(%__MODULE__{} = monkey),
    do: Enum.reduce(monkey.items, {monkey, []}, &reduce_item/2)

  defp reduce_item(item, {monkey, throws}) do
    worry =
      item
      |> monkey.operation.()
      |> div(3)

    throw =
      if Integer.mod(worry, monkey.test) == 0 do
        monkey.success
      else
        monkey.failure
      end

    monkey = %__MODULE__{monkey | inspections: monkey.inspections + 1}

    {monkey, throws ++ [{worry, throw}]}
  end
end
