require_relative "../player.rb"

class Human < Player

  def move(board)
    puts "Which space would your candy ass like to occupy?"
    gets.strip
  end
end
