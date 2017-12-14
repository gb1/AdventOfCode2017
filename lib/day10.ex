defmodule Aoc.Day10 do
  
  # @input = ["83","0","193","1","254","237","187","40","88","27","2","255","149","29","42","100"]
  @input [3,4,1,5]

  def solve() do
    
  end

  @doc ~S"""
  ix> Aoc.Day10.knot([0,1,2,3,4], 0, 3, 0)
  [2,1,0,3,4]

  iex>Aoc.Day10.knot([2,1,0,3,4], 3, 4, 1)
  [4,3,0,1,2]
  """
  def knot(list, position, input_len, skip_size) do
    
    #overlap
    {list1, list2} = Enum.split(list, position)
    IO.inspect {list1, list2}
    list = list2 ++ list1

    {list1, list2} = Enum.split(list, input_len)
    IO.inspect {Enum.reverse(list1), list2}
    list = Enum.reverse(list1) ++ list2

    {list1, list2} = Enum.split(list, skip_size - position)
    list2 ++ list1
    # {reverse, rest} = Enum.split(list, input_len)

    # Enum.reverse(reverse) ++ rest
  # knot(list, position + input_len, )
    # Stream.cycle([0,1,2,3,4]) |> Stream.take(5) |> Enum.to_list
  end

end