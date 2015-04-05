describe Grid do
  let(:size)       { 3                                 }
  let(:coordinate) { :A1                               }
  let(:cell)       { double :cell_class                }
  let(:empty_cell) { double :cell, has_content?: false }
  let(:full_cell)  { double :cell, has_content?: true  }
  let(:grid)       { Grid.new(size: size)              }

  it 'can be one by one' do
    grid = Grid.new
    expect(grid.coordinates).to eq [:A1]
  end

  it 'can be two by two' do
    grid = Grid.new(size: 2)
    expect(grid.coordinates).to eq [:A1, :A2, :B1, :B2]
  end

  it 'can get the content at a coordinate' do
    expect(grid.get_content(coordinate)).to be nil
  end

  it 'can set the content at a coordinate' do
    grid.set_content(at_coordinate: coordinate, content: :cell)
    expect(grid.get_content(coordinate)).to eq :cell
  end

  it 'can set the content at all coordinates' do
    expect(cell).to receive(:new).exactly(size * size).times

    grid.set_content_with(cell)
  end

  it 'can place a marker at a coordinate' do
    marker = :zerro
    grid.set_content(at_coordinate: coordinate, content: cell)

    expect(cell).to receive(:content=).with(marker)

    grid.place_marker(coordinate, marker)
  end

  it 'knows if the midlle is free' do
    allow(grid).to receive(:get_content).with(grid.middle_coordinate).and_return(empty_cell)

    expect(grid).to have_middle_free
  end

  it 'knows if the midlle is not free' do
    allow(grid).to receive(:get_content).with(grid.middle_coordinate).and_return(full_cell)

    expect(grid).not_to have_middle_free
  end
end
