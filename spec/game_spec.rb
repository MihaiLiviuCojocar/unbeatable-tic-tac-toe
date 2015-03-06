require 'game'

describe Game do
  let(:game)       { Game.new }
  let(:game_ready) { Game.new }

  before(:each) do
    game_ready.add_player(:player_one)
    game_ready.add_player(:player_two)
    game_ready.grid = :grid
  end

  it 'has no grid when created' do
    expect(game).not_to have_grid
  end

  it 'is not ready when created' do
    expect(game).not_to be_ready_to_start
  end

  it 'is not over when created' do
    expect(game).not_to be_over
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

  it 'cannot add players if it already has two players' do
    game.add_player(:player_one)
    game.add_player(:player_two)

    expect{game.add_player(:player_three)}.to raise_error(GameFullError, 'The game is full!')
  end

  it 'knows when it has two players' do
    game.add_player(:player_one)
    game.add_player(:player_two)

    expect(game).to have_two_players
  end

  it 'is ready to start when it has a grid and two players' do
    expect(game_ready).to be_ready_to_start
  end

  it 'knows that player one has the first move' do
    expect(game_ready.current_player).to eq(:player_one)
  end

  it 'can switch turns' do
    game_ready.switch_turns

    expect(game_ready.current_player).to eq(:player_two)
  end

  it 'knows that player one can be the winner' do
    player_one = double :player, winner?: true
    player_two = double :player, winner?: false
    game.add_player(player_one)
    game.add_player(player_two)

    expect(game.winner).to eq(player_one)
  end
end
