defmodule Day4Test do
  use ExUnit.Case

  describe "part 1" do
    test "it works for the example input" do
      assert Day4.example_input() |> Day4.split_lines() |> Day4.Part1.run() == 2
    end

    test "it runs on the real input" do
      Day4.input() |> Day4.split_lines() |> Day4.Part1.run() |> IO.inspect(label: "part 1")
    end
  end

  describe "part 2" do
    test "it works for the example input" do
      assert Day4.example_input() |> Day4.split_lines() |> Day4.Part2.run() == 4
    end

    test "it runs on the real input" do
      Day4.input() |> Day4.split_lines() |> Day4.Part2.run() |> IO.inspect(label: "part 2")
    end
  end
end
