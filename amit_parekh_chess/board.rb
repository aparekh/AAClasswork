require_relative 'pieces'

class Board
    attr_reader :rows

    def initialize(fill_board = true)
        @sentinel = NullPiece.instance
        setup_board(fill_board)
    end

    def [](pos)
        raise 'invalid position' unless valid_pos?(pos)

        row, col = pos
        @rows[row][col]
    end

    def []=(pos, val)
        raise 'invalid position' unless valid_pos?(pos)

        row, col = pos
        @rows[row][col] = val
    end

    def empty?(pos)
        self[pos].empty?
    end

    def move_piece(turn_color, start_pos, end_pos)
        raise "start position is empty" if empty?(start_pos)

        piece = self[start_pos]

        if piece.color != turn_color
            raise "You must move your own piece"
        elsif !piece.moves.include?(end_pos)
            raise "Piece cannot move like that"
        elsif !piece.valid_moves.include?(end_pos)
            raise "You cannot move into check"
        end        

        move_piece!(start_pos, end_pos)
    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]

        raise "Piece cannot move like that" unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        self[start_pos] = sentinel
        piece.pos = end_pos

        nil
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0, @rows.length - 1) }
    end

    def add_piece(piece, pos)
        raise "position not empty" unless valid_pos?(pos)

        self[pos] = piece
    end

    def in_check?(color)
        king_pos = find_king(color).pos
        pieces.any? { |piece| piece.color != color && piece.moves.include?(king_pos) }
    end

    def checkmate?(color)
        return false unless in_check?(color)

        pieces.select { |p| p.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def pieces
        @rows.flatten.reject(&:empty?)
    end
    
    def dup
        new_board = Board.new(false)

        pieces.each do |piece|
            piece.class.new(piece.color, new_board, piece.pos)
        end

        new_board
    end

    private

    attr_reader :sentinel

    def fill_back_row(color)
        back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        i = color == :white ? 7 : 0
        back_pieces.each_with_index do |piece_class, j|
            piece_class.new(color, self, [i, j])
        end
    end

    def fill_pawns(color)
        i = color == :white ? 6 : 1
        (0..7).each { |j| Pawn.new(color, self, [i, j]) }
    end

    def find_king(color)
        king = pieces.find { |p| p.color == color && p.is_a?(King) }
        king || (raise 'King not found!')
    end

    def setup_board(fill_board)
        @rows = Array.new(8) { Array.new(8, sentinel) }
        return unless fill_board
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawns(color)
        end
    end
end