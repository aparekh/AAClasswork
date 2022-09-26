require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
  end

  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner != evaluator
    end

    if evaluator == self.next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return board.won? && board.winner == evaluator
    end

    if evaluator == self.next_mover_mark
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        pos = [row_idx, col_idx]

        next unless board.empty?(pos)

        child = TicTacToeNode.new(board.dup, next_mover_mark)
        child.board[pos] = self.next_mover_mark
        child.next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
        child.prev_move_pos = pos

        children << child
      end
    end

    children
  end
end