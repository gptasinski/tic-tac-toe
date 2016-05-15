class Model
  attr_reader :values, :marked_squares
  def initialize
    @board = Array.new(3) { Array.new(3,"-") }
    @values = (1..9).to_a
    @marked_squares = Array.new(9, "-")
  end

  def mark_square(num, piece)
    marked_squares[num.to_i - 1] = piece
    values[num.to_i - 1] = piece
  end

  def mark_random(piece)
    random = values.shuffle.first
    !marked?(random) ? mark_square(random, piece) : mark_random(piece)
  end

  def piece
    strings.count.even? ? "X" : "O"
  end

  def computer_turn?
    strings.count.odd? ? true : false
  end

  def strings
    values.select { |value| value.class == String }
  end

  def computer_first_move?
    values.count("X") == 1
  end

  def computer_move
    if computer_first_move?
      center_taken? ? mark_corner(piece) : mark_center(piece)
    else
      if doubles?("X") && doubles?("O")
        block_double(doubles_location("O"), "O", "O")
      elsif doubles?("X")
        block_double(doubles_location("X"), "O", "X")
      else
        computer_attack(piece)
      end
    end
  end

  def automated_attack
    piece == "X" ? foe = "O" : foe = "X"
    piece == "O" ? friend = "O" : friend = "X"
    if doubles?(foe)
      block_double(doubles_location(foe), friend, foe)
    elsif doubles?(friend)
      block_double(doubles_location(friend), friend, friend)
    else
      mark_random(friend)
    end
  end

  def computer_attack(piece)
    doubles?(piece) ? block_double(doubles_location(piece), piece, piece) : mark_random(piece)
  end

  def doubles?(piece)
    find_doubles(rows(marked_squares), piece) ||
    find_doubles(columns(marked_squares), piece) ||
    find_doubles(diagonals(marked_squares), piece)
  end

  def find_doubles(grouping, piece)
    grouping.find { |group| group.count(piece) == 2 && group.count("-") == 1 }
  end

  def doubles_location(piece)
    if find_doubles(rows(marked_squares), piece)
      rows(marked_squares)
    elsif find_doubles(columns(marked_squares), piece)
      columns(marked_squares)
    elsif find_doubles(diagonals(marked_squares), piece)
      diagonals(marked_squares)
    else
      nil
    end
  end

  def block_double(grouping, to_mark, marked)
    if match = find_doubles(grouping, marked)
      targets = [grouping, grouping.index(match), match.index("-")]
      if targets[0] == rows(marked_squares)
        set_tic(grouping, targets)
        index = grouping.flatten.index("TIC")
        row_col_mark_block(index, to_mark)
      elsif targets[0] == columns(marked_squares)
        set_tic(grouping, targets)
        index = grouping.transpose.flatten.index("TIC")
        row_col_mark_block(index, to_mark)
      elsif targets[0].length == 2
        set_tic(grouping, targets)
        if targets[1] == 0 && targets[2] == 0
          row_col_mark_block(0, to_mark)
        elsif targets[1] == 0 && targets[2] == 2
          row_col_mark_block(8, to_mark)
        elsif targets[1] == 1 && targets[2] == 0
          row_col_mark_block(2, to_mark)
        elsif targets[1] == 1 && targets[2] == 2
          row_col_mark_block(6, to_mark)
        end
      end
    end
  end

  def set_tic(grouping, targets)
    grouping[targets[1]][targets[2]] = "TIC"
  end

  def row_col_mark_block(index, to_mark)
    mark_square(index + 1, to_mark)
  end

  def center_taken?
    values[4].class == String
  end

  def mark_center(piece)
    mark_square(5, piece)
  end

  def mark_corner(piece)
    random_corner = corners.shuffle.first
    mark_square(random_corner, piece)
  end

  def automated_first
    possibles = corners << values[4]
    mark_square(possibles.sample, piece)
  end

  def automated_second
    center_taken? ? mark_corner(piece) : mark_center(piece)
  end

  def corners
    [values[0], values[2], values[6], values[8]]
  end

  def marked?(num)
    values[num.to_i - 1].class == String ? true : false
  end

  def rows(value_set)
    value_set.each_slice(3).to_a
  end

  def columns(value_set)
    value_set.each_slice(3).to_a.transpose
  end

  def diagonals(value_set)
    diagonals = [[value_set[0], value_set[4], value_set[8]], [value_set[2], value_set[4], value_set[6]]]
  end

  def match(grouping)
    grouping.find { |group| group.join == "OOO" || group.join == "XXX"}
  end

  def winner?
    (match(rows(values)) || match(columns(values)) || match(diagonals(values))) ? true : false
  end

  def tie?
    strings.count == 9
  end

  def complete?
    winner? || tie?
  end
end