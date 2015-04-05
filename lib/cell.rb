require 'exceptions'

class Cell
  attr_reader :content

  def has_content?
    !@content.nil?
  end

  def content=(content)
    raise CellAlreadyMarkedError if has_content?
    @content = content
  end
end
