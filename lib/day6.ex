defmodule Aoc.Day6 do
  
  # problem input
  # @banks [10,	3, 15, 10, 5,	15,	5, 15, 9,	2, 5, 8, 5, 2, 3,	6]
  
  # sample input:
  @banks [0, 2, 7, 0]

  @dupe [2,4,1,2]
  # @dupe [1, 1, 0, 15, 14, 13, 12, 10, 10, 9, 8, 7, 6, 4, 3, 5]

  @doc ~S"""
  solve part 1
  iex>Aoc.Day6.solve
  5
  """
  def solve() do
    banks = @banks |> list_to_map
    banks |> spread_banks(0, [Map.values(banks)], false, 0)
  end

  def spread_banks(_banks, swaps, new_banks, true, swaps_count) do
    IO.puts "part 1:"
    IO.inspect swaps
    IO.inspect new_banks |> List.last
    IO.puts "part 2:"
    IO.inspect swaps_count - 1
  end

  def spread_banks(banks, swaps, new_banks, _found_dupe, swaps_count) do
    {start, moves} = banks |> max_value
    
    banks = Map.put(banks, start, 0)
    updates = get_indices_to_update(Map.values(banks), start, moves)
    banks = banks
    |> update_banks(updates)

    new_banks = new_banks ++ [Map.values(banks)]

    swaps_count = case Enum.member?(new_banks, @dupe) do
      true -> swaps_count + 1
      false -> swaps_count
    end

    spread_banks(banks, swaps + 1, new_banks, match?(new_banks), swaps_count)
  end

  @doc ~S"""
  Look for a duplicate in the current list of bank states
  iex>Aoc.Day6.match?([[1,2], [1,2]])
  true
  iex>Aoc.Day6.match?([[2,1], [1,2]])
  false
  """
  def match?(bank_state) do
    bank_state != Enum.uniq bank_state
  end

  @doc ~S"""
  Converts a list to a map with the index as the key
  iex> Aoc.Day6.list_to_map [1, 2, 3]
  %{0 => 1, 1 => 2, 2 => 3}
  """
  def list_to_map(list) do
    list
    |> Enum.with_index
    |> Enum.map(fn({x,y}) -> {y,x} end)
    |> Map.new
  end

  @doc ~S"""
  returns a tuple {postion, value} of the largest value in the map
  iex> Aoc.Day6.max_value %{1 => 1, 2 => 2, 3 => 3}
  {3, 3}
  """
  def max_value(map) do
    Enum.max_by(map, fn({_k, v}) -> v end)
  end

  @doc ~S"""
  returns a list of indices to update, wrapping around list
  iex> Aoc.Day6.get_indices_to_update([0, 2, 7, 0], 2, 7)
  [3, 0, 1, 2, 3, 0, 1]
  """
  def get_indices_to_update(banks, start, moves) do
    Stream.cycle(0..length(banks) - 1) 
    |> Stream.take(start + moves + 1)
    |> Enum.map(&(&1))
    |> Enum.drop(start+1)
  end

  @doc ~S"""
  iex> Aoc.Day6.update_banks(%{1 => 2, 2 => 3, 3 => 4}, [1, 2, 3])
  %{1 => 3, 2 => 4, 3 => 5}
  """
  def update_banks(banks, indices) do
    indices |> Enum.reduce(banks, fn(i, acc) -> 
      acc |> Map.update!(i, &(&1 + 1))
    end)
  end

end