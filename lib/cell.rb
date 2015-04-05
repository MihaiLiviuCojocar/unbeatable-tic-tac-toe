class Cell
  attr_accessor :content

  def has_content?
    !@content.nil?
  end
end
