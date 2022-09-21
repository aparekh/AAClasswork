require_relative 'poly_tree_node'

class KnightPathFinder
    attr_reader :start_pos

    BOARD_LENGTH = 8
    POSSIBLE_MOVES = [[2, 1], [2, -1], [1, -2], [-1, -2], [-2, 1], [-2, -1], [1, 2], [-1, 2]]

    def self.valid_moves(pos)
        valid_moves = []
        x, y = pos

        POSSIBLE_MOVES.each do |(dx, dy)|
            new_pos = [x + dx, y + dy]
            valid_moves << new_pos if new_pos.all? { |coord| coord.between?(0, BOARD_LENGTH - 1) }
        end

        valid_moves
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]

        build_move_tree
    end

    private

    attr_accessor :root_node, :considered_positions

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)

        node_queue = Queue.new
        node_queue.enq(root_node)

        until node_queue.empty?
            current_node = node_queue.deq
            valid_positions = new_move_positions(current_node.value).map { |pos| PolyTreeNode.new(pos) }
            
            valid_positions.each do |node|
                current_node.add_child(node)
                node_queue.enq(node)
            end
        end
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
            .reject { |new_pos| considered_positions.include?(new_pos) }
            .each { |new_pos| considered_positions << new_pos }
    end
end