require 'cell'

describe Cell do
  it 'has no content when created' do
    cell = Cell.new

    expect(cell).not_to have_content
  end

  it 'can have content' do
    cell = Cell.new

    cell.content = :cross

    expect(cell).to have_content
  end
end
