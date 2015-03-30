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

  it 'needs a grid when initialized' do
    solutions_calculator = SolutionsCalculator.new(grid: :grid)
    expect(solutions_calculator.grid).to eq :grid
  end

  it 'needs a marker when initialized' do
    solutions_calculator = SolutionsCalculator.new(grid: :grid, marker: :cross)
    expect(solutions_calculator.marker).to eq :cross
  end

  it 'knows all possible combinations' do
    grid = double :grid
    solutions_calaculator = SolutionsCalculator.new(grid: grid)
    allow(grid).to receive(:matrix).and_return(
    {
      A1: 'X', B1: 'X', C1: 'O',
      A2: '~', B2: '~', C2: 'X',
      A3: 'O', B3: 'X', C3: '~'
    })

    expect(solutions_calaculator.possible_combinations).to eq(
      [
        ['X', 'X', 'O'],
        ['~', '~', 'X'],
        ['O', 'X', '~'],
        ['X', '~', 'O'],
        ['X', '~', 'X'],
        ['O', 'X', '~'],
        ['X', '~', '~'],
        ['O', '~', 'O']
      ])
  end
end
