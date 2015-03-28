require 'grid'

describe Grid do
  it 'can be one by one' do
    grid = Grid.new
    expect(grid.coordinates).to eq [:A1]
  end

  it 'can be two by two' do
    grid = Grid.new(size: 2)
    expect(grid.coordinates).to eq [:A1, :A2, :B1, :B2]
  end
end
