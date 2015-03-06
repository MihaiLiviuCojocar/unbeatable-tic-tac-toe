require 'game'

describe Game do
  let(:game) { Game.new }

  it 'has no grid when created' do
    expect(game).not_to have_grid
  end

  it 'can have a grid' do
    game.grid = :grid

    expect(game).to have_grid
  end

  it 'has no players when created' do
    expect(game).not_to have_two_players
  end

  it 'can add the first player' do
    game.add_player(:player_one)

    expect(game).to have_player_one
  end
end
