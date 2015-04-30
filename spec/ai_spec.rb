describe Ai do
  let(:grid) { double :grid       }
  let(:ai)   { Ai.new(grid: grid) }

  it 'his name is "Computer"' do
    grid = double :grid
    ai   = Ai.new(grid: grid)
    expect(ai.name).to eq 'Computer'
  end
end
