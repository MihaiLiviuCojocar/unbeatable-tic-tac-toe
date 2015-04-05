require_relative '../loader'
require 'terminal-table'

class Interface
  attr_reader :name, :game, :grid

  def initialize
    @game = Game.new
    @grid = Grid.new(size: 3)
    @grid.set_content_with(Cell)
  end

  def add_player
    puts "New player required!"
    puts "What is your name?"
    name = gets.chomp
    game.add_player(Player.new(name: name, grid: grid))
    puts "Player one: #{game.player_one.name}" if game.has_player_one?
    puts "Player two: #{game.player_two.name}" if game.has_player_two?
  end

  def fight!
    add_player
    add_player
    prepare_players
    keep_playing
  end

  def keep_playing
    until game.over? or game.draw?
      show_grid
      play
    end
  end

  def prepare_players
    @game.player_one.marker = :X
    @game.player_one.solutions_calculator = SolutionsCalculator.new(grid: grid, marker: :X)
    @game.player_two.marker = :O
    @game.player_two.solutions_calculator = SolutionsCalculator.new(grid: grid, marker: :O)
    puts "Game is now ready to start!"
  end

  def play
    puts "Current player to move is #{@game.current_player.name}."
    puts "Where do you want to place your marker(#{@game.current_player.marker})?"
    coordinate = gets.chomp
    @game.make_move(coordinate.to_sym)
  end

  def rows
    grid.matrix.values.map { |cell| cell.content }.each_slice(3).to_a
  end

  def show_grid
    table = Terminal::Table.new
    table.title = 'Tic Tac Toe'
    table.headings = [*1..3].unshift(" ")
    letters = [*"A".."C"]
    table.rows = rows.each_with_index do |row, index|
      row.unshift(letters[index])
    end
    puts table
  end
end
