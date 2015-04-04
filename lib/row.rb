class Row
  attr_reader :cells, :marker

  def initialize(opt = {})
    @cells  = opt.fetch(:cells)
    @marker = opt.fetch(:marker)
  end

  def has_available_cell_for_marking?
  end
end
