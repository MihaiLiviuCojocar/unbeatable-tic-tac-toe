require 'solutions_calculator'

describe SolutionsCalculator do
  let(:grid)                 { double :grid                                       }
  let(:row_class)            { double :row_class                                  }
  let(:marker)               { :cross                                             }
  let(:solutions_calculator) { SolutionsCalculator.new grid: grid, marker: marker }

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
    expect(solutions_calculator.grid).to eq grid
  end

  it 'needs a marker when initialized' do
    expect(solutions_calculator.marker).to eq marker
  end

  it 'knows all possible combinations' do
    allow(grid).to receive(:matrix).and_return(
      {
        A1: 'X', B1: 'X', C1: 'O',
        A2: '~', B2: '~', C2: 'X',
        A3: 'O', B3: 'X', C3: '~'
      })
    rows = [
        ['X', 'X', 'O'],
        ['~', '~', 'X'],
        ['O', 'X', '~'],
        ['X', '~', 'O'],
        ['X', '~', 'X'],
        ['O', 'X', '~'],
        ['X', '~', '~'],
        ['O', '~', 'O']
      ]

    rows.each do |row|
      expect(row_class).to receive(:new).with(row).ordered
    end

    solutions_calculator.possible_combinations(row_class)
  end

  it 'knows the winning solutions' do
    row_one = double :row, winning_solution: [:A1]
    row_two = double :row, winning_solution: [:B2]
    allow(solutions_calculator).to receive(:possible_combinations).and_return([
        row_one,
        row_two
      ])

    expect(solutions_calculator.winning_solutions).to eq [:A1, :B2]
  end
end
