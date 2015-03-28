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
end
