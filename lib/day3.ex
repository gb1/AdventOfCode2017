defmodule Aoc.Day3 do

  #@input 361_527 - 1
  @input 100 - 1
  @north {0,1}
  @south {0,-1}
  @east {1,0}
  @west {-1,0}

  defmodule Spiral do
    defstruct coords: {1,0}, direction: {1,0}, points: MapSet.new([{0,0},{1,0}]),
      val_points: %{{0,0} => 1, {1,0} => 1}
  end

  def solve() do
    #part 1
    spiral = gen_spiral(1, %Spiral{})
    # IO.inspect manhattan_distance(spiral.coords)
  
    #part 2
    IO.inspect spiral
  end

  # check the point to the left of the current postion
  # if it's a point, go forward one place, if it's free then turn
  # left and go forward one place
  def gen_spiral(@input, spiral), do: spiral
  def gen_spiral(i, spiral) do
    spiral = case point_to_left(spiral) do
      true ->
        spiral |> part_two_forward
      false ->
        spiral 
        |> turn_left
        |> part_two_forward 
    end
    gen_spiral(i+1, spiral)
  end

  def point_to_left(spiral) do
    case spiral.direction do
      @north -> spiral.points |> MapSet.member?(add_vector(spiral.coords, @west))
      @south -> spiral.points |> MapSet.member?(add_vector(spiral.coords, @east))
      @east -> spiral.points |> MapSet.member?(add_vector(spiral.coords, @north))
      @west -> spiral.points |> MapSet.member?(add_vector(spiral.coords, @south))
    end
  end

  def turn_left(spiral) do
    direction = case spiral.direction do
      @north -> @west
      @south -> @east
      @east -> @north
      @west -> @south
    end
    
    %Spiral{spiral | direction: direction}
  end

  def move_forward(spiral) do
    forward = case spiral.direction do
      @north -> add_vector(spiral.coords, @north)
      @south -> add_vector(spiral.coords, @south)
      @east -> add_vector(spiral.coords, @east)
      @west -> add_vector(spiral.coords, @west)
    end

    %Spiral{spiral | coords: forward, points: MapSet.put(spiral.points, forward)}
  end

  def add_vector({x,y}, {vx, vy}) do
    {x + vx, y + vy}
  end

  def manhattan_distance({x,y}) do
    abs(x) + abs(y)
  end

  def part_two_forward(spiral) do
    forward = case spiral.direction do
      @north -> add_vector(spiral.coords, @north)
      @south -> add_vector(spiral.coords, @south)
      @east -> add_vector(spiral.coords, @east)
      @west -> add_vector(spiral.coords, @west)
    end

    value = neighbours_sum(forward, spiral)
    IO.inspect [forward, value]
    IO.puts "-------"

    %Spiral{spiral | coords: forward, points: MapSet.put(spiral.points, forward),
      val_points: Map.put(spiral.val_points, forward, value) }
  end

  def neighbours_sum({x,y}, spiral) do
    n = [
      Map.get(spiral.val_points, {x-1, y-1}),
      Map.get(spiral.val_points, {x, y-1}),
      Map.get(spiral.val_points, {x+1, y-1}),
      Map.get(spiral.val_points, {x-1, y}),
      Map.get(spiral.val_points, {x+1, y}),
      Map.get(spiral.val_points, {x+1, y+1}),
      Map.get(spiral.val_points, {x, y+1}),
      Map.get(spiral.val_points, {x-1, y+1})
    ]
    |> Enum.filter(&(&1 != nil)) 
    |> Enum.sum
    if n > 361_527 do
      IO.puts "result:"
      IO.inspect n
    end
    n
  end

end