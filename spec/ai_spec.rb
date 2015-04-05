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
          allow(grid).to receive(:has_middle_free?).and_return(true)
          allow(grid).to receive(:middle_coordinate).and_return(:B2)

          expect(grid).to receive(:place_marker).with(middle_coordinate, marker)

          ai.make_first_move
        end
      end

      context 'when the middle is not free' do
        it 'takes a corner' do
          allow(grid).to receive(:has_middle_free?).and_return(false)
          allow(grid).to receive(:corner_coordinates).and_return([:A1])

          expect(grid).to receive(:place_marker).with(:A1, marker)

          ai.make_first_move
        end
      end
    end

    context 'making the second move' do
      it 'defends if needed' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:A1])

        expect(grid).to receive(:place_marker).with(:A1, marker)

        ai.make_second_move
      end

      it 'defends if needed' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:C1])

        expect(grid).to receive(:place_marker).with(:C1, marker)

        ai.make_second_move
      end
    end
  end
end
