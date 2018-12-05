defmodule GuardTest do
  use ExUnit.Case

  @guard %Guard{schedules: [0..10, 10..14, 20..24]}

  test "total_sleeps" do
    assert Guard.total_sleeps(@guard) == 21
  end

  test "most_slept" do
    assert Guard.most_slept(@guard) == 10
  end

end
