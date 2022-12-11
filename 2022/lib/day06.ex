defmodule Day6 do
  def input(), do: File.read!("inputs/day06.txt")
  def example_input(), do: File.read!("inputs/day06_example.txt")
  def split_lines(input), do: String.split(input, "\n", trim: true) |> hd()

  def position_first_unique_group_with_size(input, size) do
    size +
      (input
       |> String.graphemes()
       |> Enum.chunk_every(size, 1)
       |> Enum.with_index()
       |> Enum.find(&all_unique/1)
       |> elem(1))
  end

  defp all_unique({strings, _index}) do
    Enum.uniq(strings) == strings
  end
end

defmodule Day6.Part1 do
  def run(input) do
    Day6.position_first_unique_group_with_size(input, 4)
  end
end

defmodule Day6.Part2 do
  def run(input) do
    Day6.position_first_unique_group_with_size(input, 14)
  end
end
