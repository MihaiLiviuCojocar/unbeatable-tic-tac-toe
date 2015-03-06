require 'game'

describe Game do
  it 'has no grid when created' do
    game = Game.new

    expect(game).not_to have_grid
  end
end
