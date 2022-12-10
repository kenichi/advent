defmodule AdventTest do
  use ExUnit.Case

  @test_input_1 "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
  @test_input_2 "bvwbjplbgvbhsrlpgdmjqwftvncz"
  @test_input_3 "nppdvjthqldpwncqszvftbrmjlhg"
  @test_input_4 "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
  @test_input_5 "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

  def test_somm(input) do
    input
    |> Advent.Input.parse()
    |> Advent.start_of_message_marker()
  end

  test "start_of_message_marker/1 - 1" do
    assert test_somm(@test_input_1) == 19
  end

  test "start_of_message_marker/1 - 2" do
    assert test_somm(@test_input_2) == 23
  end

  test "start_of_message_marker/1 - 3" do
    assert test_somm(@test_input_3) == 23
  end

  test "start_of_message_marker/1 - 4" do
    assert test_somm(@test_input_4) == 29
  end

  test "start_of_message_marker/1 - 5" do
    assert test_somm(@test_input_5) == 26
  end
end
