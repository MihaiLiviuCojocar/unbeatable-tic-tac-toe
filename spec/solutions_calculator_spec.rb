require 'solutions_calculator'

describe SolutionsCalculator do
  it 'has a list of coordinates of all possible winning combinations' do
    expect(SolutionsCalculator::WINNING_COMBINATIONS).to eq (
      [
        [:A1, :B1, :C1],
        [:A2, :B2, :C2],
        [:A3, :B3, :C3],
        [:A1, :A2, :A3],
        [:B1, :B2, :B3],
        [:C1, :C2, :C3],
        [:A1, :B2, :C3],
        [:A3, :B2, :C1]
      ])
  end
end
