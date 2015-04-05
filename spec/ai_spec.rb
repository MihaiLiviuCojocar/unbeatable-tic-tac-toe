describe Ai do
  it 'has a name' do
    grid = double :grid
    ai   = Ai.new(grid: grid)
    expect(ai.name).to eq 'Computer'
  end
end
