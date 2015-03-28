require 'grid'

describe Grid do
  let(:size)       { 3                    }
  let(:coordinate) { :A1                  }
  let(:cell)       { double :cell         }
  let(:grid)       { Grid.new(size: size) }

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
end
