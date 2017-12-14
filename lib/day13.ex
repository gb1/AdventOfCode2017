defmodule Aoc.Day13 do 
  import IEx 
  defmodule Wall do
    defstruct scanner_pos: 1, bricks: 0, direction: :down
  end 

  def solve() do
  end

  @doc ~S"""
  Turn a line into a tuple in a list
  iex> Aoc.Day13.parse_input(["0: 3", "1: 2", "4: 4"])
  [{0,3},{1,2},{4,4}]
  """
  def parse_input(input) do
    input
    |> Enum.map( fn(x) ->
      x 
      |> String.split(": ") 
      |> Enum.map(&(String.to_integer(&1)))
      |> List.to_tuple
    end)
  end

  @doc ~S"""
  Build the initial firewalls
  iex> Aoc.Day13.build_walls([{0,3},{1,2}], %{})
  %{ 0 => %Aoc.Day13.Wall{scanner_pos: 0, bricks: 3, direction: :down},1 => %Aoc.Day13.Wall{scanner_pos: 0, bricks: 2,direction: :down}}
  """
  def build_walls([], walls), do: walls
  def build_walls([wall | rest], walls) do
    w = %Wall{scanner_pos: 0, bricks: elem(wall,1), direction: :down}
    build_walls(rest, walls |> Map.put(elem(wall,0), w))
  end

  def tick(walls, position) do
    # m |> Enum.reduce(m, fn({k, v}, i) -> Map.put(i, 0, 0) end)
  end

  def move_wall_scanner(wall) do
    # List.update_at
    IO.inspect wall
    cond do
      wall.direction == :down && wall.scanner_pos == wall.bricks  ->
        wall = %Wall{wall | scanner_pos: wall.scanner_pos - 1}
        %Wall{wall | direction: :up}
      wall.direction == :down ->
        wall = %Wall{wall | scanner_pos: wall.scanner_pos + 1}
      wall.direction == :up && wall.scanner_pos == 1  ->
        wall = %Wall{wall | scanner_pos: wall.scanner_pos + 1}
        %Wall{wall | direction: :down}
      wall.direction == :up -> 
        %Wall{wall | scanner_pos: wall.scanner_pos - 1}
    end
  end

  def move_scanner_down(x) do #["S" | rest]) do
    # ["", "S", rest]
    # IEx.pry()
    
    0
  end
end