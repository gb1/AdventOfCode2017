defmodule Aoc.Day24 do

  def read_input() do
    File.read!("./input/day24_sample.txt")
    |> String.split("\n", trim: true)
    |> Enum.map( fn(x) ->
      [a, b] = String.split(x, "/")
      {String.to_integer(a), String.to_integer(b)}
    end)
  end

  #find all possible next components for the given bridge
  def possible_next_components( [head | tail], components) do
    {comp_x, comp_y} = head
    components
    |> Enum.filter( &(!Enum.member?(tail, &1)))
    |> Enum.filter( &(!Enum.member?(Tuple.to_list(&1), 0)))
    |> Enum.filter( &(&1 != {comp_x, comp_y}))
    |> Enum.filter( fn({x, y}) ->
      x == comp_x or x == comp_y or y == comp_x or y == comp_y
    end)
  end

  #find all possible next bridges for the given bridge
  def possible_next_bridges(bridge, components) do
    bridge
    |> possible_next_components(components)
    |> Enum.map(&([&1] ++ bridge))

  end

  def create_bridges(bridges, components) do
    new_bridges = bridges
    |> Enum.map(&(possible_next_bridges(&1, components)))

    #IO.inspect new_bridges

    # create_bridges(new_bridges, components)
  end

end
