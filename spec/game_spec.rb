require 'game'

describe Game do
  it 'has no grid when created' do
    game = Game.new

    expect(game).not_to have_grid
  end

  it 'can have a grid' do
    game = Game.new

    game.grid = :grid

    expect(game).to have_grid
  end
end
