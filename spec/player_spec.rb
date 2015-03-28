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

    expect(grid).to receive(:place_marker).with(at_coordinate: coordinate, marker: :zerro)

    player.place_marker(coordinate)
  end

  it 'knows where he placed his marker on the grid' do
    coordinate    = :A1
    player.marker = :zerro
    allow(grid).to receive(:place_marker).with(at_coordinate: coordinate, marker: :zerro)

    player.place_marker(coordinate)

    expect(player.marked_coordinates).to eq [:A1]
  end
end
