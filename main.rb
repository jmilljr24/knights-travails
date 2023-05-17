class Node
  attr_accessor :pre_pos, :square, :cost

  def initialize(square, pre_pos = [], cost)
    @square = square
    @pre_pos = pre_pos
    @cost = cost
  end
end
MOVE = [[1, 2], [-2, -1], [-1, 2], [2, -1],
        [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

def knight_moves(start_pos, end_pos)
  if start_pos.any? { |x| x < 0 || x > 8 } || end_pos.any? { |x| x < 0 || x > 8 }
    puts 'Position not on board. Pick position numbers 0-8'
    return
  end
  @solutions = []
  @visited = [start_pos]
  queue = [Node.new(start_pos, nil, 0)]
  move(queue[0].square, end_pos, queue)
  print(@solutions[0], path)
end

def move(current, end_pos, queue)
  return if queue.empty?

  MOVE.each do |m|
    new_move = Node.new([current[0] + m[0], current[1] + m[1]], queue[0], queue[0].cost + 1)
    next if new_move.square.any? { |x| x < 0 || x > 8 }

    next if !(new_move.square == end_pos) && @visited.include?(new_move.square)

    @solutions << new_move if new_move.square == end_pos
    @visited << new_move.square
    queue << new_move
  end
  queue.shift
  return if queue.empty?

  move(queue[0].square, end_pos, queue)
end

def path
  squares = []
  current = @solutions[0]
  loop do
    squares << current.square
    current = current.pre_pos
    break if current.nil?
  end
  squares
end

def print(node, path)
  puts "You made it in #{node.cost} moves! Heres your path:"
  path.reverse!
  path.each do |i|
    p i
  end
end
knight_moves([0, 0], [8, 7])
