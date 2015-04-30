describe Game do
  let(:grid)       { double :grid                                  }
  let(:game)       { Game.new(grid: grid)                          }
  let(:game_ready) { Game.new(grid: grid)                          }
  let(:player_one) { double :player, winner?: false, name: 'Mihai' }
  let(:player_two) { double :player, winner?: false, name: 'Roi'   }

  before(:each) do
    game_ready.add_player(player_one)
    game_ready.add_player(player_two)
  end

  it 'is not ready when created' do
    expect(game).not_to be_ready_to_start
  end

  it 'is not over when created' do
    allow(game).to receive(:available_moves_count).and_return(9)
    expect(game).not_to be_over
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
    expect{game_ready.add_player(:player_three)}.to raise_error(GameFullError, 'The game is full!')
  end

  it 'knows when it has two players' do
    expect(game_ready).to have_two_players
  end

  it 'is ready to start when it has a grid and two players' do
    expect(game_ready).to be_ready_to_start
  end

  it 'knows that player one has the first move' do
    expect(game_ready.current_player).to eq(player_one)
  end

  it 'can switch turns' do
    allow(game_ready).to receive(:available_moves_count).and_return(9)
    game_ready.switch_turns
    expect(game_ready.current_player).to eq(player_two)
  end

  it 'knows that player one can be the winner' do
    allow(player_one).to receive(:winner?).and_return(true)
    expect(game_ready.winner).to eq(player_one)
  end

  it 'knwos that player two can be the winner' do
    allow(player_two).to receive(:winner?).and_return(true)
    expect(game_ready.winner).to eq(player_two)
  end

  it 'is over if there is a winner' do
    allow(player_two).to receive(:winner?).and_return(true)
    expect(game_ready).to be_over
  end

  it 'cannot switch turns if there is a winner' do
    allow(player_one).to receive(:winner?).and_return(true)
    expect{game_ready.switch_turns}.to raise_error('Game over! Mihai wins!')
  end

  it 'can find a player by name' do
    expect(game_ready.find_player_by_name('Mihai')).to eq(player_one)
  end

  it 'makes a move for the current player' do
    allow(game_ready).to receive(:available_moves_count).and_return(9)
    expect(player_one).to receive(:place_marker).with(:A1)
    game_ready.make_move(:A1)
  end

  it 'switches the turnes after making a move' do
    allow(game_ready).to receive(:available_moves_count).and_return(9)
    allow(player_one).to receive(:place_marker).with(:A1)
    game_ready.make_move(:A1)
    expect(game_ready.current_player).to eq(player_two)
  end

  it 'knows that there is a draw if it makes the last move and there is no winner' do
    allow(game_ready).to receive(:available_moves_count).and_return(0)
    allow(player_one).to receive(:place_marker).with(:A1)
    expect{ game_ready.make_move(:A1) }.to raise_error(DrawGameError, 'Draw! Nobody wins! :)')
  end
end
