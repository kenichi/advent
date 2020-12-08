defmodule Advent do
  @moduledoc false

  @doc """
  Return count of valid passports.
  """
  @spec eval(List.t()) :: integer()
  def eval(passports \\ Advent.Input.parse()) do
    Enum.reduce(passports, 0, &inc_valid/2)
  end

  defp inc_valid(%{byr: _, iyr: _, eyr: _, hgt: _, hcl: _, ecl: _, pid: _} = p, c) do
    if valid_data?(p), do: c + 1, else: c
  end

  defp inc_valid(_, c), do: c

  @doc """
  True if passport has valid data, false otherwise.

  ## Examples

  iex> Advent.valid_data?(%{byr: "1980", iyr: "2012", eyr: "2030", hgt: "74in", hcl: "#623a2f", ecl: "grn", pid: "087499704"})
  true

  iex> Advent.valid_data?(%{byr: "1989", iyr: "2014", eyr: "1967", hgt: "165cm", hcl: "#a97842", ecl: "blu", pid: "896056539"})
  false

  """
  @spec eval(Map.t()) :: boolean()
  def valid_data?(passport) do
    Enum.all?([
      valid_byr?(passport),
      valid_iyr?(passport),
      valid_eyr?(passport),
      valid_hgt?(passport),
      valid_hcl?(passport),
      valid_ecl?(passport),
      valid_pid?(passport)
    ])
  end

  defp valid_byr?(%{byr: byr}) do
    val = String.to_integer(byr)
    val >= 1920 && val <= 2002
  end

  defp valid_iyr?(%{iyr: iyr}) do
    val = String.to_integer(iyr)
    val >= 2010 && val <= 2020
  end

  defp valid_eyr?(%{eyr: eyr}) do
    val = String.to_integer(eyr)
    val >= 2020 && val <= 2030
  end

  defp valid_hgt?(%{hgt: hgt}) do
    cond do
      String.ends_with?(hgt, "cm") ->
        val = String.replace_trailing(hgt, "cm", "") |> String.to_integer()
        val >= 150 && val <= 193

      String.ends_with?(hgt, "in") ->
        val = String.replace_trailing(hgt, "in", "") |> String.to_integer()
        val >= 59 && val <= 76

      true ->
        false
    end
  end

  defp valid_hcl?(%{hcl: hcl}), do: Regex.match?(~r/^\#[0-9a-f]{6}$/, hcl)

  defp valid_ecl?(%{ecl: "amb"}), do: true
  defp valid_ecl?(%{ecl: "blu"}), do: true
  defp valid_ecl?(%{ecl: "brn"}), do: true
  defp valid_ecl?(%{ecl: "gry"}), do: true
  defp valid_ecl?(%{ecl: "grn"}), do: true
  defp valid_ecl?(%{ecl: "hzl"}), do: true
  defp valid_ecl?(%{ecl: "oth"}), do: true
  defp valid_ecl?(%{ecl: _}), do: false

  defp valid_pid?(%{pid: pid}), do: Regex.match?(~r/^[0-9]{9}$/, pid)
end
