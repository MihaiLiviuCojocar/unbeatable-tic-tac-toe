require 'player'

describe Player do
  let(:player) { Player.new(name: 'Mihai') }

  it 'has a name when created' do
    expect(player.name).to eq('Mihai')
  end

  it 'is not a winner when created' do
    expect(player).not_to be_winner
  end

  it 'can have a marker' do
    player.marker = :cross

    expect(player.marker).to eq(:cross)
  end

  it 'can have a grid' do
    player.grid = :grid
    expect(player.grid).to eq :grid
  end
end
