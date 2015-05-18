module MatrixBuilder
  DEFAULT_VALUE = nil

  def build_matrix(size)
    [*'A'..equivalent_letter_for(size)].map do |letter|
      [*1..size].map do |number|
        { "#{letter}#{number}".to_sym => DEFAULT_VALUE }
      end
    end.flatten.reduce(:merge)
  end

  private

  def equivalent_letter_for(number)
    (number + 64).chr
  end  
end