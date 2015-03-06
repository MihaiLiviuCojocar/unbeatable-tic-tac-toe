class Cell
  attr_writer :content

  def has_content?
    !@content.nil?
  end
end
