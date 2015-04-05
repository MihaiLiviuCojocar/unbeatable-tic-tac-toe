describe Ai do
  let(:grid)                   { double :grid                 }
  let(:ai)                     { Ai.new(grid: grid)           }
  let(:solutions_calculator)   { double :solutions_calculator }
  let(:middle_coordinate)      { :B2                          }
  let(:marker)                 { :cross                       }

  it 'has a name' do
    grid = double :grid
    ai   = Ai.new(grid: grid)
    expect(ai.name).to eq 'Computer'
  end

  context 'moving' do
    before do
      ai.marker               = :cross
      ai.solutions_calculator = solutions_calculator
    end

    context 'making the first move' do
      context 'when the middle is free' do
        it 'takes it' do
          allow(grid).to receive(:is_middle_free?).and_return(true)

          expect(grid).to receive(:place_marker).with(middle_coordinate, marker)

          ai.make_first_move
        end
      end

      context 'when the middle is not free' do
        it 'takes a corner' do
        end
      end
    end
  end
end
