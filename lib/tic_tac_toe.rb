require 'pry'
class TicTacToe
    attr_accessor :board
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        self.board = []
        9.times {self.board << " "}
        # self.board = [1,2,3,4,5,6,7,8,9]
    end

    def display_board
        puts
        i = 0
        while i < 7
            puts  " #{self.board[i]} | #{self.board[i+1]} | #{self.board[i+2]} "
            i += 3
            puts "-----------" if i < 7 
        end
        puts
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] != " "
    end

    def valid_move?(index)
        index.between?(0,8) && !self.position_taken?(index)
    end

    def turn_count
         self.board.select {|position| position != " "}.count
    end

    def current_player
        return "O" if self.board.select {|pos| pos == "O"}.count < self.board.select {|pos| pos == "X"}.count
        "X"
    end

    def turn
        c_p = self.current_player
        puts "Current Player: " + c_p
        puts "Please make a move"
        input = gets.chomp
        input = self.input_to_index(input)
        # binding.pry
        if self.valid_move?(input) == true
            self.move(input,c_p)
            self.display_board
        else
            # binding.pry
            puts "Invalid"
            self.turn
        end   
    end

    def won?
        o_positions = []
        x_positions = []
        self.board.each_with_index do |el, i|
            o_positions << i if el == "O"
            x_positions << i if el == "X"
        end

        WIN_COMBINATIONS.each do |combo|
            return combo if combo & o_positions == combo
            return combo if combo & x_positions == combo
        end
        false
    end

    def full?
        self.board.select {|pos|pos == " "}.count == 0
    end

    def draw?
        return true if !self.won? && self.full?
        false
    end

    def over?
        return true if self.won? || self.draw?
        false
    end

    def winner
        return nil if !self.won?
        self.board[self.won?[0]]
    end

    def play
        # binding.pry
        # self.turn
        # if over?
        #     if won?
        #         puts "Congratulations #{self.winner}!"
        #     end
        #     if draw?
        #         puts "Cat\s Game!"
        #     end
        # else
        #     self.play
        # end

        until over?
            self.turn
        end

        if won?
            puts "Congratulations #{self.winner}!"
        else
            puts "Cat\'s Game!"
        end
    end
end