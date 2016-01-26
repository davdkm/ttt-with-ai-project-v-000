require 'pry'

class Player::Computer < Player

  def move(board)
    if !board.taken?(5)
      '5'
    elsif random > 7
      random
    else
      cpu_move(board).to_i + 1
    end
  end

  def random
    rand(1..9)
  end

  def cpu_move(board)
    win(board) || block(board) || random
  end

  def combo_move?(board, token)
    Game::WIN_COMBINATIONS.detect do |combo|
      (
        (board.cells[combo[0]] == token && board.cells[combo[1]] == token) &&
        !board.taken?(combo[2] + 1)
      ) ||
      (
        (board.cells[combo[1]] == token && board.cells[combo[2]] == token) &&
        !board.taken?(combo[0] + 1)
      ) ||
      (
        (board.cells[combo[0]] == token && board.cells[combo[2]] == token) &&
        !board.taken?(combo[1] + 1)
      )
    end
  end

  def win(board)
    win_combo = combo_move?(board, self.token)
    if win_combo && win_combo.count{|index| board.position(index + 1) == self.token} == 2
      win_combo.detect{|index| !board.taken?(index + 1)}
    end
  end

  def block(board)
    block = combo_move?(board, self.opponent_token)
    if block && block.count{|index| board.position(index + 1) == self.opponent_token} == 2
      block.detect{|index| !board.taken?(index + 1)}
    end
  end

  def opponent_token
    self.token == "X" ? "O" : "X"
  end
end
