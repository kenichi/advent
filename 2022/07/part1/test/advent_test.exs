defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  describe "Advent.Input" do
    test "parse/1" do
      assert Advent.Input.parse(@test_input) == %{
               "a" => %{
                 "e" => %{
                   "i" => 584
                 },
                 "f" => 29116,
                 "g" => 2557,
                 "h.lst" => 62596
               },
               "b.txt" => 14_848_514,
               "c.dat" => 8_504_156,
               "d" => %{
                 "j" => 4_060_174,
                 "d.log" => 8_033_020,
                 "d.ext" => 5_626_152,
                 "k" => 7_214_296
               }
             }
    end
  end

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "small_directories_sizes/1", %{input: input} do
      assert Advent.small_directories_sizes(input) == [94853, 584]
    end
  end
end
