module MatrixBuilder
  def build_matrix(size)
    [*'A'..equivalent_letter_for(size)].map do |letter|
      [*1..size].map do |number|
        { "#{letter}#{number}".to_sym => nil }
      end
    end.flatten.reduce(:merge)
  end

  private

  def equivalent_letter_for(number)
    (number + 64).chr
  end  
end