defmodule Aoc.Day7 do
  
  def part1() do
    input = File.read!("./input/day7.txt")
    |> String.split("\n", trim: true)
    
    #what fresh hell is this?
    vertices = input
    |> Enum.map(&( 
      {Enum.at(String.split(&1, "-> "),0) |> String.split(" ") |> Enum.at(0),
       Enum.at(String.split(&1, "-> "),1)}
      ))
    |> Enum.filter( &( elem(&1, 1) != nil ))
    |> Enum.map( fn({x,y}) -> {x, String.split(y, ", ")} end)
    |> Enum.reduce(%{}, fn(x, acc) ->
      
      children = elem(x, 1)
      parent = elem(x, 0)

      children
      |> Enum.reduce(acc, fn(x2, acc2) ->
        Map.put(acc2, x2, parent)
      end)
    end)
    
    find_parent(vertices, Enum.at(vertices, 0) |> elem(0))
  end

  def find_parent(vertices, current) do
    case vertices[current] do
      nil -> current
      _parent -> find_parent(vertices, vertices[current])
    end
  end

  def part2() do
    input = File.read!("./input/day7.txt")
    |> String.split("\n", trim: true)

    # input = File.read!("./input/day7_sample.txt")
    # |> String.split("\r\n", trim: true)

    weights = node_weights(input)
    adj_list = build_adjacency_list(input)

    adj_list["cwwwj"]
    |> Enum.each(fn(x) ->
      IO.inspect x
      IO.inspect get_node_total_weight(x, adj_list, weights)
    end)

  end

  def node_weights(input) do
    input
    |> Enum.map(&(String.split(&1, " ") |> Enum.take(2)))
    |> Enum.map( fn(node) ->
      name = Enum.at(node, 0)
      weight = Enum.at(node, 1)

      weight = Regex.run(~r/\d+/, weight)
      |> List.first
      |> String.to_integer

      {name, weight}
    end)
    |> Map.new
  end

  def build_adjacency_list(input) do
    input
    |> Enum.map(&( 
      {Enum.at(String.split(&1, "-> "),0) |> String.split(" ") |> Enum.at(0),      
        case Enum.at(String.split(&1, "-> "),1) do
          nil -> []
          _ -> String.split(Enum.at(String.split(&1, "-> "),1), ", ")
        end
      }))
    |> Map.new
  end

  def get_all_children([], children, _adj_list), do: children
  def get_all_children([head | tail], children, adj_list) do
    children = children ++ adj_list[head]
    tail = tail ++ adj_list[head]
    get_all_children(tail, children, adj_list)
  end

  def get_node_total_weight(node, adj_list, weights) do
    children = get_all_children([node], [], adj_list)
    child_weights = children
    |> Enum.reduce(0, fn(x, acc) ->
      acc + weights[x]
    end)

    child_weights + weights[node]
  end

  def get_next_row(_row, _adj_list) do
    # row
    # |> Enum.reduce([], fn(x, acc) ->
      
    # end)
  end

end