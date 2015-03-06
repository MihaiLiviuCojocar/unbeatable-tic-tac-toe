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
end
