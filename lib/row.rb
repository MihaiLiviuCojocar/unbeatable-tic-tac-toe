class Row
  EMPTY_CELL = Proc.new { |cell| cell.content.nil? }

  attr_reader :cells, :marker

  def initialize(opt = {})
    @cells  = opt.fetch(:cells)
    @marker = opt.fetch(:marker)
  end

  def has_available_cell_for_marking?
    cells.any?(&EMPTY_CELL)
  end
end
