require 'player'

describe Player do
  let(:grid)   { double :grid                          }
  let(:player) { Player.new(name: 'Mihai', grid: grid) }

  it 'has a name when created' do
    expect(player.name).to eq('Mihai')
  end

  it 'has a grid when created' do
    expect(player.grid).to eq grid
  end

  it 'is not a winner when created' do
    expect(player).not_to be_winner
  end

  it 'can have a marker' do
    player.marker = :cross

    expect(player.marker).to eq(:cross)
  end

  it 'can place his marker on the grid at a coordinate' do
    coordinate    = :A1
    player.marker = :zerro
    solutions_calculator        = double :solutions_calculator
    player.solutions_calculator = solutions_calculator
    allow(solutions_calculator).to receive(:winning_solutions).and_return([])

    expect(grid).to receive(:place_marker).with(coordinate, :zerro)

    player.place_marker(coordinate)
  end

  it 'has a solutions calculator' do
    player.solutions_calculator = :solutions_calculator
    expect(player.solutions_calculator).to eq :solutions_calculator
  end

  it 'knwos the winning solutions' do
    solutions_calculator        = double :solutions_calculator
    player.solutions_calculator = solutions_calculator

    expect(solutions_calculator).to receive(:winning_solutions)

    player.winning_solutions
  end

  it 'knows that he wins if he marks a coordinate which is a solution' do
    solutions_calculator        = double :solutions_calculator
    player.solutions_calculator = solutions_calculator
    player.marker               = :zerro
    allow(solutions_calculator).to receive(:winning_solutions).and_return([:A3])
    allow(grid).to receive(:place_marker).with(:A3, :zerro)

    player.place_marker(:A3)

    expect(player).to be_winner
  end
end
