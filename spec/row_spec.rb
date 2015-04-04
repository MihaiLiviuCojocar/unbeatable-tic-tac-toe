require 'row'

describe Row do
  it 'is initialized with a list of cells' do
    row = Row.new(cells: [:cell1, :cell2, :cell3])
    expect(row.cells).to eq [:cell1, :cell2, :cell3]
  end
end
