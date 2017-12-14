defmodule Aoc.Day10 do
  
  # @input = ["83","0","193","1","254","237","187","40","88","27","2","255","149","29","42","100"]
  @input [3,4,1,5]

  def solve() do
    
  end

  @doc ~S"""
  iex> Aoc.Day10.knot([0,1,2,3,4], 0, 3, 0)
  [2,1,0,3,4]

  iex>Aoc.Day10.knot([2,1,0,3,4], 3, 4, 3)
  []
  """
  def knot(list, position, input_len, skip_size) do
    {reverse, rest} = Enum.split(list, input_len)

    Enum.reverse(reverse) ++ rest
  # knot(list, position + input_len, )
    # Stream.cycle([0,1,2,3,4]) |> Stream.take(5) |> Enum.to_list
  end

end