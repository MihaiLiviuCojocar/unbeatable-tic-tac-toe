require 'solutions_calculator'

describe SolutionsCalculator do
  let(:cell_with_cross)              { double :cell, content: 'X', has_content?: true      }
  let(:cell_with_zerro)              { double :cell, content: 'O'                          }
  let(:empty_cell)                   { double :cell, content: nil, has_content?: false     }
  let(:another_empty_cell)           { double :cell, content: nil                          }
  let(:row_without_solution)         { [cell_with_cross, cell_with_zerro, cell_with_cross] }
  let(:another_row_without_solution) { [cell_with_cross, cell_with_zerro, empty_cell]      }
  let(:row_with_solution)            { [cell_with_cross, cell_with_cross, empty_cell]      }

  it 'has a list of coordinates of all possible winning combinations' do
    expect(SolutionsCalculator::POSSIBLE_COMBINATIONS).to eq (
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

  it 'knows if there is an available cell to be marked in a row' do
    solutions_calculator = SolutionsCalculator.new(grid: :grid)
    expect(solutions_calculator.any_available_cell_for_marking_in?(row_with_solution)).to be true
  end

  xit 'knows the winning solutions' do
    grid = double :grid
    solutions_calculator = SolutionsCalculator.new(grid: grid, marker: 'X')
    allow(grid).to receive(:matrix).and_return(
      {
        A1: empty_cell,         B1: cell_with_cross, C1: cell_with_zerro,
        A2: another_empty_cell, B2: cell_with_cross, C2: cell_with_cross,
        A3: cell_with_cross,    B3: cell_with_zerro, C3: empty_cell
      })

      expect(solutions_calculator.winning_solutions).to eq [:A2]
  end

  xit 'knows the winning solutions' do
    grid = double :grid
    solutions_calculator = SolutionsCalculator.new(grid: grid, marker: 'O')
    allow(grid).to receive(:matrix).and_return(
      {
        A1: empty_cell,      B1: cell_with_cross, C1: cell_with_zerro,
        A2: cell_with_zerro, B2: cell_with_cross, C2: cell_with_cross,
        A3: cell_with_zerro, B3: cell_with_zerro, C3: another_empty_cell
      })

      expect(solutions_calculator.winning_solutions).to eq [:A1, :C3]
  end
end
