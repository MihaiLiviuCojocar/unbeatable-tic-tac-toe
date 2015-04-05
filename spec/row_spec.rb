describe Row do
  let(:cell_with_cross)      { double :cell, content: 'X', has_content?: true      }
  let(:cell_with_zerro)      { double :cell, content: 'O', has_content?: true      }
  let(:empty_cell)           { double :cell, content: nil, has_content?: false     }
  let(:row_without_solution) { [cell_with_cross, cell_with_zerro, cell_with_cross] }
  let(:row_with_solution)    { [cell_with_cross, cell_with_cross, empty_cell]      }
  let(:another_row)          { [cell_with_cross, cell_with_zerro, empty_cell]      }

  it 'is initialized with a list of cells' do
    row = Row.new(cells: [:cell1, :cell2, :cell3], marker: 'X')

    expect(row.cells).to eq [:cell1, :cell2, :cell3]
  end

  it 'is initialized with a marker' do
    row = Row.new(cells: [], marker: 'X')

    expect(row.marker).to eq 'X'
  end

  it 'knows if it has not any available cell for marking' do
    row = Row.new(cells: row_without_solution, marker: 'X')

    expect(row).not_to have_one_available_cell_for_marking
  end

  it 'knows if it has any available cell for marking' do
    row = Row.new(cells: row_with_solution, marker: 'X')

    expect(row).to have_one_available_cell_for_marking
  end

  it 'knows if it has only my marker' do
    row = Row.new(cells: row_with_solution, marker: 'X')

    expect(row).to have_only_my_marker
  end

  it 'knows if it has not only my marker' do
    row = Row.new(cells: another_row, marker: 'X')

    expect(row).not_to have_only_my_marker
  end

  it 'knows if there is any opportunity to win' do
    row = Row.new(cells: row_with_solution, marker: 'X')

    expect(row).to have_an_opportunity_to_win
  end

  it 'knows if there is no opportunity to win' do
    row = Row.new(cells: another_row, marker: 'X')

    expect(row).not_to have_an_opportunity_to_win
  end

  it 'knows the the winning cell' do
    row = Row.new(cells: row_with_solution, marker: 'X')

    expect(row.winning_cell).to eq empty_cell
  end
end
