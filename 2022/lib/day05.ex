defmodule Day5 do
  def input(), do: File.read!("inputs/day05.txt")
  def example_input(), do: File.read!("inputs/day05_example.txt")
  def split_lines(input), do: String.split(input, "\n")

  def run(lines, move_fun) do
    {stacks, moves} = Day5.parse_lines(lines)

    stacks =
      for {amount, from_stack_no, to_stack_no} <- moves,
          reduce: stacks do
        acc -> move_fun.(acc, amount, from_stack_no, to_stack_no)
      end

    result =
      for stack_no <- 1..map_size(stacks), into: "" do
        CrateStacksMap.peek(stacks, stack_no)
      end

    result
  end

  def parse_lines(lines) do
    idx_first_move_line = Enum.find_index(lines, &move_line?/1)
    {crates_lines, rest} = Enum.split(lines, idx_first_move_line - 2)
    {[_stack_numbers_line], rest} = Enum.split(rest, 1)
    move_lines = Enum.filter(rest, &move_line?/1)
    parsed_crates_lines = crates_lines |> Enum.map(&parse_crates_line/1) |> Enum.reverse()
    parsed_move_lines = move_lines |> Enum.map(&parse_move_line/1)

    stacks =
      for crates_line <- parsed_crates_lines,
          {crate, stack_no} <- Enum.with_index(crates_line, 1),
          reduce: %{} do
        acc -> CrateStacksMap.push(acc, stack_no, crate)
      end

    {stacks, parsed_move_lines}
  end

  defp move_line?(line), do: String.starts_with?(line, "move")

  defp parse_crates_line(line), do: parse_crates_line(line, []) |> Enum.reverse()
  defp parse_crates_line("", acc), do: acc

  defp parse_crates_line(rest, acc) do
    crate =
      case String.slice(rest, 1..1) do
        " " -> nil
        crate -> crate
      end

    parse_crates_line(String.slice(rest, 4..-1), [crate | acc])
  end

  defp parse_move_line(line) do
    case Regex.run(~r/move (\d+) from (\d+) to (\d+)/, line, capture: :all_but_first) do
      nil ->
        raise("invalid input #{line}")

      [_, _, _] = operation ->
        operation |> Enum.map(&String.to_integer/1) |> List.to_tuple()
    end
  end
end

defmodule CrateStack do
  def new(crate), do: [crate]
  def push(stack, nil), do: stack
  def push(stack, crate), do: [crate | stack]
  def pop([_crate | rest] = _stack), do: rest
  def peek([crate | _rest]), do: crate
end

defmodule CrateStacksMap do
  def push(stacks, _stack_no, nil), do: stacks

  def push(stacks, stack_no, crate) do
    Map.update(stacks, stack_no, CrateStack.new(crate), fn stack ->
      CrateStack.push(stack, crate)
    end)
  end

  def pop(stacks, stack_no),
    do: Map.update!(stacks, stack_no, fn stack -> CrateStack.pop(stack) end)

  def peek(stacks, stack_no), do: Map.fetch!(stacks, stack_no) |> CrateStack.peek()
end

defmodule Day5.Part1 do
  def run(lines) do
    Day5.run(lines, &move_crates/4)
  end

  defp move_crates(stacks, 0, _from_stack_no, _to_stack_no), do: stacks

  defp move_crates(stacks, amount, from_stack_no, to_stack_no) when amount > 0 do
    crate = CrateStacksMap.peek(stacks, from_stack_no)
    stacks = CrateStacksMap.pop(stacks, from_stack_no)
    stacks = CrateStacksMap.push(stacks, to_stack_no, crate)
    move_crates(stacks, amount - 1, from_stack_no, to_stack_no)
  end
end

defmodule Day5.Part2 do
  def run(lines) do
    Day5.run(lines, &move_crates/4)
  end

  defp move_crates(stacks, 0, _from_stack_no, _to_stack_no), do: stacks

  defp move_crates(stacks, amount, from_stack_no, to_stack_no) when amount > 0 do
    move_crates(stacks, [], amount, from_stack_no, to_stack_no)
  end

  defp move_crates(stacks, [], 0, _from_stack_no, _to_stack_no), do: stacks

  defp move_crates(stacks, buffer, amount, from_stack_no, to_stack_no) when amount > 0 do
    crate = CrateStacksMap.peek(stacks, from_stack_no)
    stacks = CrateStacksMap.pop(stacks, from_stack_no)
    move_crates(stacks, [crate | buffer], amount - 1, from_stack_no, to_stack_no)
  end

  defp move_crates(stacks, [crate | rest], 0, from_stack_no, to_stack_no) do
    stacks = CrateStacksMap.push(stacks, to_stack_no, crate)
    move_crates(stacks, rest, 0, from_stack_no, to_stack_no)
  end
end
