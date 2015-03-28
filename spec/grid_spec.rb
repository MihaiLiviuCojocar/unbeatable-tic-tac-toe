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

  it 'can get the content at a coordinate' do
    grid = Grid.new(size: 3)
    expect(grid.get_content(:B2)).to be nil
  end

  it 'can set the content at a coordinate' do
    grid = Grid.new(size: 3)
    grid.set_content(at_coordinate: :B3, content: :cell)
    expect(grid.get_content(:B3)).to eq :cell
  end

  it 'can set the content at all coordinates' do
    size = 3
    cell = double :cell
    grid = Grid.new(size: size)

    expect(cell).to receive(:new).exactly(size * size).times

    grid.set_content_with(cell)
  end
end
