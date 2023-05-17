class Node
  attr_accessor :pre_pos, :square, :cost

  def initialize(square, pre_pos, cost)
    @square = square
    @pre_pos = pre_pos
    @cost = cost
  end
end
MOVE = [[1, 2], [-2, -1], [-1, 2], [2, -1],
        [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze
# MOVE = [[1, 2], [2, 1]].freeze
def knight_moves(start_pos, end_pos)
  @solutions = []
  @visited = [start_pos]
  queue = [Node.new(start_pos, nil, 0)]
  move(queue[0].square, end_pos, queue)
  p @solutions
end

def move(current, end_pos, queue)
  return if queue.empty?

  MOVE.each do |m|
    new_move = Node.new([current[0] + m[0], current[1] + m[1]], current, queue[0].cost + 1)
    next if new_move.square.any? { |x| x < 0 || x > 8 }

    next if !(new_move.square == end_pos) && @visited.include?(new_move.square)

    if new_move.square == end_pos
      @solutions << new_move
      # break
    end
    @visited << new_move.square
    queue << new_move
  end
  queue.shift
  return if queue.empty?

  move(queue[0].square, end_pos, queue)
end

knight_moves([0, 0], [3, 3])
