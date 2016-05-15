require_relative "model"
require_relative "view"

class Controller
  attr_reader :view, :game, :players

  def initialize(game, view)
    @game = game
    @view = view
    @players = 0
  end

  def run
    view.welcome
    view.print_board(game.values)
    view.ask_for_players
    set_players
  end

  def set_players
    players = gets.chomp
    view.player_error if !(0..2).to_a.include?(players.to_i)
    if players == "0"
      run_automated_play
    elsif players == "1"
      @players = 1
      run_one_player
    else
      @players = 2
      run_two_players
    end
  end

  def run_automated_play
    automated(game.automated_first)
    automated(game.automated_second)
    until game.complete?
      automated(game.automated_attack)
    end
  end

  def automated(attack)
    attack
    view.print_board(game.values)
    sleep(1)
    winner_check
  end

  def run_one_player
    until game.complete?
      one_player_move
    end
  end

  def one_player_move
    view.next(game.piece)
    choice = gets.chomp
    if game.marked?(choice)
      marked_square
    else
      game.mark_square(choice, game.piece)
      view.print_board(game.values)
      winner_check
    end
  end

  def run_two_players
    until game.complete?
      move
    end
  end

  def move
    view.next(game.piece)
    choice = gets.chomp
    if game.marked?(choice)
      marked_square
    else
      game.mark_square(choice, game.piece)
      view.print_board(game.values)
      winner_check
    end
  end

  def winner_check
    view.congrats if game.winner?
    view.tie if game.tie?
    move if @players == 2
    if @players == 1
      game.computer_turn? ? automated_one : one_player_move
    end
  end

  def automated_one
    view.wait
    automated(game.computer_move)
  end

  def marked_square
    view.already_marked
  end
end

new_game = Controller.new(Model.new, View.new)
new_game.run