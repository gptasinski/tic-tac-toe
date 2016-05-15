class View

  def welcome
    puts "Welcome to Very Simple Tic-Tac-Toe"
  end

  def num_players
    puts "How many players? 0, 1 or 2?"
  end

  def instructions
    puts "The first player will be 'X', the second will be 'O'."
    puts "Type the corresponding number to mark the square."
    puts "
      1 =  ----- ----- -----
          |     |     |     |
          |  X  |  2  |  3  |
          |     |     |     |
           ----- ----- -----
          |     |     |     |
          |  4  |  5  |  6  |
          |     |     |     |
           ----- ----- -----
          |     |     |     |
          |  7  |  8  |  9  |
          |     |     |     |
           ----- ----- -----
      "
  end

  def print_board(values)
    puts "       ----- ----- -----
      |     |     |     |
      |  #{values[0]}  |  #{values[1]}  |  #{values[2]}  |
      |     |     |     |
       ----- ----- -----
      |     |     |     |
      |  #{values[3]}  |  #{values[4]}  |  #{values[5]}  |
      |     |     |     |
       ----- ----- -----
      |     |     |     |
      |  #{values[6]}  |  #{values[7]}  |  #{values[8]}  |
      |     |     |     |
       ----- ----- -----
    "
  end

  def ask_for_players
    puts "How many players? 0, 1 or 2?"
  end

  def player_error
    puts "This is a game for 0 - 2 players. Choose a number in that range, or divide up into teams if you have to."
    exit
  end

  def wait
    puts "THE COMPUTER IS THINKING"
  end

  def congrats
    puts "We have a winner!"
    exit
  end

  def tie
    puts "There is a tie, you are both winners!"
    exit
  end

  def next(name)
    puts "Type the number of a square to mark it with an #{ name }:"
  end

  def already_marked
    puts "So sorry. That square has already been marked. Focus a little harder and try again:"
  end
end