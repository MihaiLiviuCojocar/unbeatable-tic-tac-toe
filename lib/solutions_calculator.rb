class SolutionsCalculator
  WINNING_COMBINATIONS = [
    [:A1, :B1, :C1],
    [:A2, :B2, :C2],
    [:A3, :B3, :C3],
    [:A1, :A2, :A3],
    [:B1, :B2, :B3],
    [:C1, :C2, :C3],
    [:A1, :B2, :C3],
    [:A3, :B2, :C1]
  ]

  attr_reader :grid, :marker

  def initialize(options = {})
    @grid   = options[:grid]
    @marker = options[:marker]
  end
end
