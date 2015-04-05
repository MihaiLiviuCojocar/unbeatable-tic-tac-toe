describe Cell do
  let(:cell) { Cell.new }

  it 'has no content when created' do
    expect(cell).not_to have_content
  end

  it 'can have content' do
    cell.content = :cross

    expect(cell).to have_content
  end

  it 'cannot have the content changed if it already has some content' do
    cell.content = :cross

    expect{ cell.content = :zerro }.to raise_error(CellAlreadyMarkedError, 'This cell has already been marked!')
  end
end
