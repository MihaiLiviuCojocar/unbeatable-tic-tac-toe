class SolutionsCalculator
  attr_reader :game, :marker

  def initialize(options = {})
    @game   = options[:game]
    @marker = options[:marker]
  end

  def grid
    game.grid
  end

  def possible_combinations
    coordinates_of_possible_combinations.map do |row|
      Row.new(cells: row.map { |coordinate| grid.matrix[coordinate] }, marker: marker)
    end
  end

  def winning_solutions
    possible_combinations.map do |row|
      get_key_of(row.winning_cell)
    end.compact
  end

  def defending_solutions
    possible_combinations.map do |row|
      get_key_of(row.defending_cell)
    end.compact
  end

  private

  def coordinates_of_possible_combinations
    row1 = get_vertical_rows
    row2 = get_horizantal_rows

    sol1 = []
    sol2 = []
    
    row1.each_with_index do |item, index|
      sol1 << item[index]
    end

    row2.each_with_index do |item, index|
      sol2 << item.reverse[index]
    end

    solutions =  get_horizantal_rows
    solutions += get_vertical_rows
    solutions << sol1
    solutions << sol2
  end

  def get_horizantal_rows
    grid.matrix.keys.map do |key|
      grid.matrix.keys.select do |coord|
        coord.to_s.chars.last == key.to_s.chars.last
      end
    end.uniq
  end

  def get_vertical_rows
    get_horizantal_rows.transpose
  end

  def get_key_of(cell)
    grid.matrix.key(cell)
  end
end
