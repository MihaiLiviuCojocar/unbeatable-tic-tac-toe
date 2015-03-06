require 'cell'

describe Cell do
  let(:cell) { Cell.new }

  it 'has no content when created' do
    expect(cell).not_to have_content
  end

  it 'can have content' do
    cell.content = :cross

    expect(cell).to have_content
  end
end
