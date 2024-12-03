defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> safe_reports_count()
  end

  @doc """
  Count number of "safe" reports.
  """
  @spec safe_reports_count([[integer()]]) :: integer()
  def safe_reports_count(reports) do
    reports
    |> Enum.map(&safe_report?/1)
    |> Enum.filter(& &1)
    |> length()
  end

  @spec safe_report?([integer()]) :: boolean()
  defp safe_report?(report) do
    with intervals <- parse_intervals(report),
         true <- all_inc_or_dec?(intervals),
         true <- intervals_within_spec?(intervals) do
      true
    else
      false ->
        false
    end
  end

  @spec parse_intervals([integer()]) :: [integer()]
  defp parse_intervals(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  @spec all_inc_or_dec?([integer()]) :: boolean()
  defp all_inc_or_dec?(intervals) do
    Enum.all?(intervals, &(&1 < 0)) or Enum.all?(intervals, &(&1 > 0))
  end

  @spec intervals_within_spec?([integer()]) :: boolean()
  defp intervals_within_spec?(intervals) do
    Enum.all?(intervals, fn i ->
      ai = abs(i)
      ai > 0 and ai < 4
    end)
  end
end
