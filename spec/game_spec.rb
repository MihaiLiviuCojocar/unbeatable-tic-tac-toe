require 'game'

describe Game do
  let(:game) { Game.new }

  it 'has no grid when created' do
    expect(game).not_to have_grid
  end

  it 'is not ready when created' do
    expect(game).not_to be_ready_to_start
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

  it 'can add the second player' do
    game.add_player(:player_one)
    game.add_player(:player_two)

    expect(game).to have_player_two
  end

  it 'knows when it has two players' do
    game.add_player(:player_one)
    game.add_player(:player_two)

    expect(game).to have_two_players
  end

  it 'is ready to start when it has a grid and two players' do
    game.add_player(:player_one)
    game.add_player(:player_two)
    game.grid = :grid

    expect(game).to be_ready_to_start
  end
end
