class SolutionsCalculator
  attr_reader :grid, :marker

  POSSIBLE_COMBINATIONS = [
    [:A1, :B1, :C1],
    [:A2, :B2, :C2],
    [:A3, :B3, :C3],
    [:A1, :A2, :A3],
    [:B1, :B2, :B3],
    [:C1, :C2, :C3],
    [:A1, :B2, :C3],
    [:A3, :B2, :C1]
  ]

  def initialize(options = {})
    @grid   = options[:grid]
    @marker = options[:marker]
  end

  def possible_combinations(row_class)
    POSSIBLE_COMBINATIONS.map do |row|
      row_class.new(row.map { |coordinate| grid.matrix[coordinate] })
    end
  end
end
