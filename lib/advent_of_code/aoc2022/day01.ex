defmodule AdventOfCode.AoC2022.Day1 do
  def input(), do: File.read!("inputs/day01.txt")
  def example_input(), do: File.read!("inputs/day01_example.txt")

  def part1(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn elve_calories ->
      String.split(elve_calories, "\n")
      |> Enum.reject(fn v -> v == "" end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.max()
  end

  def part2(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn elve_calories ->
      String.split(elve_calories, "\n")
      |> Enum.reject(fn v -> v == "" end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
