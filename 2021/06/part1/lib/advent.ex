defmodule Advent do

  @spec eval(List.t()) :: Integer.t()
  def eval(fish \\ Advent.Input.parse(), days \\ 80) do
    school =
      Enum.reduce(1..days, fish, fn _day, fs ->
        {school, spawn} =
          Enum.reduce(fs, {[], 0}, fn f, {school, spawn} ->
            case f - 1 do
              -1 -> {[6 | school], spawn + 1}
              n -> {[n | school], spawn}
            end
          end)

        spawned =
          case spawn do
            0 -> []
            n -> for _ <- 1..n, do: 8
          end

        Enum.reverse(school) ++ spawned
      end)

    length(school)
  end
end
