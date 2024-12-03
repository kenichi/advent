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
    Enum.reduce(reports, 0, fn r, c ->
      cond do
        safe_report?(r) ->
          c + 1

        dampened_safe_report?(r) ->
          c + 1

        true ->
          c
      end
    end)
  end

  @spec safe_report?([integer()]) :: boolean()
  defp safe_report?(report) do
    with intervals <- parse_intervals(report),
         true <- all_inc_or_dec?(intervals) do
      intervals_within_spec?(intervals)
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

  @spec dampened_safe_report?([integer()]) :: boolean()
  defp dampened_safe_report?(report) do
    Enum.reduce_while(0..length(report), false, fn n, _ ->
      report
      |> List.delete_at(n)
      |> safe_report?()
      |> if(do: {:halt, true}, else: {:cont, false})
    end)
  end
end
