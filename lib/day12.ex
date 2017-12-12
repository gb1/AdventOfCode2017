defmodule Aoc.Day12 do
  
  def solve() do
    #part 1
    File.read!("./input/day12.txt") |> String.trim
    |> String.split("\n")
    |> build_adj_list
    |> find_children(["0"], ["0"])
    |> length
    |> IO.inspect
  
    #part 2
    File.read!("./input/day12.txt") |> String.trim
    |> String.split("\n")
    |> build_adj_list
    |> find_groups([], 0)
  
  end

  def build_adj_list(input) do
    input
    |> Enum.reduce(%{}, fn(x,acc) ->
      [node, children] = x |> String.split(" <-> ")
      Map.put(acc, node, String.split(children, ", ", trim: true))
    end)
  end

  def find_children(_adj_list, [], seen), do: seen 
  def find_children(adj_list, [child | children], seen) do    
    next_children = adj_list[child]
    next_children = next_children |> Enum.reject(&(Enum.member?(seen, &1)))

    find_children(adj_list, children ++ next_children, seen ++ next_children) 
  end

  def find_groups(adj_list, groups, 1999) do
     
     Enum.map(groups, &(List.first(&1)))
     |> Enum.sort
     |> Enum.dedup
     |> length
  end

  def find_groups(adj_list, groups, check) do
    num = Integer.to_string(check)
    groups = groups ++ [Enum.sort(find_children(adj_list, [num], [num]))]
    find_groups(adj_list, groups, check+1)
  end

end