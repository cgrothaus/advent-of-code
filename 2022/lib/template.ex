defmodule Template do
  def input(), do: File.read!("inputs/day01.txt")
  def example_input(), do: File.read!("inputs/day01_example.txt")
  def split_lines(input), do: String.split(input, "\n", trim: true)
end

defmodule Template.Part1 do
  def run(_input) do
    0
  end
end

defmodule Template.Part2 do
  def run(_input) do
    0
  end
end
