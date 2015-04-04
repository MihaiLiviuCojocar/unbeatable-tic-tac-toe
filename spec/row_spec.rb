require 'row'

describe Row do
  it 'is initialized with a list of cells' do
    row = Row.new(cells: [:cell1, :cell2, :cell3], marker: :cross)
    expect(row.cells).to eq [:cell1, :cell2, :cell3]
  end

  it 'is initialized with a marker' do
    row = Row.new(cells: [], marker: :cross)
    expect(row.marker).to eq :cross
  end
end
