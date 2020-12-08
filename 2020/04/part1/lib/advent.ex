defmodule Advent do
  @moduledoc false

  @doc """
  Return count of valid passports.
  """
  @spec eval(List.t()) :: integer()
  def eval(passports \\ Advent.Input.parse()) do
    Enum.reduce(passports, 0, &inc_valid/2)
  end

  defp inc_valid(%{byr: _, iyr: _, eyr: _, hgt: _, hcl: _, ecl: _, pid: _}, c), do: c + 1
  defp inc_valid(_, c), do: c
end
