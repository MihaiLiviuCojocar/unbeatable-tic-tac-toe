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
      before do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([])
      end
      
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
      before do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([])
      end

      it 'knows if he needs to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:A1])

        expect(ai.need_to_defend?).to be true
      end

      it 'knows if he doesnt need to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([])

        expect(ai.need_to_defend?).to be false
      end

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

      it 'marks a middle if he doesnt need to defend' do
        allow(ai).to receive(:need_to_defend?).and_return(false)
        # allow(solutions_calculator).to receive(:defending_solutions).and_return([])
        allow(grid).to receive(:middle_line_coordinates).and_return([:A2])

        expect(grid).to receive(:place_marker).with(:A2, marker)

        ai.make_second_move
      end
    end
  end
end
