defmodule Aoc.Day5 do

  def read_file_and_solve() do
    # part 1
    File.read!("./input/day5.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> jump(0,0)
    |> IO.inspect

    # part 2
    File.read!("./input/day5.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> jump2(0,0)
    |> IO.inspect
  end

  def jump(list, position, jumps) when position >= length(list), do: jumps
  def jump(list, position, jumps) do
    jump(
      List.update_at(list, position, &(&1 + 1)),
      position + Enum.at(list, position),
      jumps + 1
    )
  end

  def jump2(list, position, jumps) when position >= length(list) or position < 0 do
    jumps
  end
  def jump2(list, position, jumps) do
    
    if rem(jumps, 100000) == 0 do
      IO.puts jumps  
    end
    increment = cond do
      Enum.at(list, position) >= 3 ->
        -1
      true -> 1
    end

    jump2(
      List.update_at(list, position, &(&1 + increment)),
      position + Enum.at(list, position),
      jumps + 1
    )
  end

end