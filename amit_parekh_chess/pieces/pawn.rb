require_relative 'piece'

class Pawn < Piece

    def symbol
        '♟'.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        pos[0] == (color == :white) ? 6 : 1
    end

    def forward_dir
        color == :white ? -1 : 1
    end

    def forward_steps
        x, y = pos

        one_step = [x + forward_dir, y]
        return [] unless board.valid_pos?(one_step) && board.empty?(one_step)

        steps = [one_step]
        two_step = [x + 2 * forward_dir, y]
        steps << two_step if at_start_row? && board.empty?(two_step)

        steps
    end
    
    def side_attacks
        x, y = pos
        side_moves = [[x + forward_dir, y - 1], [x + forward_dir, y + 1]]

        side_moves.select do |new_pos|
            next false unless board.valid_pos?(new_pos)
            next false if board.empty?(new_pos)

            threatened_piece = board[new_pos]
            threatened_piece && threatened_piece.color != color
        end
    end
end