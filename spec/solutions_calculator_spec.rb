describe SolutionsCalculator do
  let(:grid)                 { double :grid                                       }
  let(:row_class)            { double :row_class                                  }
  let(:marker)               { :cross                                             }
  let(:solutions_calculator) { SolutionsCalculator.new grid: grid, marker: marker }

  context 'providing solutions' do
    it 'has a list of coordinates of all possible winning combinations' do
      expect(SolutionsCalculator::POSSIBLE_COMBINATIONS).to eq (
        [
          [:A1, :B1, :C1],
          [:A2, :B2, :C2],
          [:A3, :B3, :C3],
          [:A1, :A2, :A3],
          [:B1, :B2, :B3],
          [:C1, :C2, :C3],
          [:A1, :B2, :C3],
          [:A3, :B2, :C1]
        ])
    end

    it 'needs a grid when initialized' do
      expect(solutions_calculator.grid).to eq grid
    end

    it 'needs a marker when initialized' do
      expect(solutions_calculator.marker).to eq marker
    end

    it 'knows all possible combinations' do
      allow(grid).to receive(:matrix).and_return(
        {
          A1: 'X', B1: 'X', C1: 'O',
          A2: '~', B2: '~', C2: 'X',
          A3: 'O', B3: 'X', C3: '~'
        })
      rows = [
          ['X', 'X', 'O'],
          ['~', '~', 'X'],
          ['O', 'X', '~'],
          ['X', '~', 'O'],
          ['X', '~', 'X'],
          ['O', 'X', '~'],
          ['X', '~', '~'],
          ['O', '~', 'O']
        ]

      rows.each do |row|
        expect(Row).to receive(:new).with(cells: row, marker: marker).ordered
      end

      solutions_calculator.possible_combinations
    end

    it 'knows the winning solutions' do
      empty_cell         = double :cell
      another_empty_cell = double :cell
      row_one            = double :row, winning_cell: empty_cell
      row_two            = double :row, winning_cell: another_empty_cell
      allow(grid).to receive(:matrix).and_return(
        {
          A1: empty_cell, B1: 'O', C1: 'O',
          A2: 'X',        B2: 'X', C2: another_empty_cell,
          A3: 'O',        B3: 'X', C3: '~'
        })
      allow(solutions_calculator).to receive(:possible_combinations).and_return([
          row_one,
          row_two
        ])

      expect(solutions_calculator.winning_solutions).to eq [:A1, :C2]
    end

    it 'knows the defending solutions' do
      empty_cell         = double :cell
      another_empty_cell = double :cell
      row_one            = double :row, defending_cell: empty_cell
      row_two            = double :row, defending_cell: another_empty_cell
      allow(grid).to receive(:matrix).and_return(
        {
          A1: empty_cell, B1: 'X', C1: 'X',
          A2: 'O',        B2: 'O', C2: another_empty_cell,
          A3: 'O',        B3: 'X', C3: '~'
        })
      allow(solutions_calculator).to receive(:possible_combinations).and_return([
          row_one,
          row_two
        ])

      expect(solutions_calculator.defending_solutions).to eq [:A1, :C2]
    end
  end

  context 'making recomandations for' do
    context 'first move' do
      context 'when the middle is free' do
        it 'recommends the middle' do
          allow(grid).to receive(:has_middle_free?).and_return(true)
          allow(grid).to receive(:middle_coordinate).and_return(:B2)

          expect(solutions_calculator.first_move_recommendation).to eq(:B2)
        end
      end

      context 'when the middle is not free' do
        it 'recommends a corner' do
          allow(grid).to receive(:has_middle_free?).and_return(false)
          allow(grid).to receive(:corner_coordinates).and_return([:A1])

          expect(solutions_calculator.first_move_recommendation).to eq(:A1)
        end
      end
    end

    context 'second move' do
      it 'knows if it needs to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:A1])

        expect(solutions_calculator.need_to_defend?).to be true
      end

      it 'knows if it doesnt need to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([])

        expect(solutions_calculator.need_to_defend?).to be false
      end

      it 'makes a recommandation to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:A1])

        expect(solutions_calculator.second_move_recommendation).to eq(:A1)
      end

      it 'makes a recommandation to defend' do
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:C1])

        expect(solutions_calculator.second_move_recommendation).to eq(:C1)
      end

      it 'recommends the middle of a line if doesnt need defending' do
        allow(solutions_calculator).to receive(:need_to_defend?).and_return(false)
        allow(grid).to receive(:middle_line_coordinates).and_return([:A2])
        allow(grid).to receive(:available_cells_coordinates).and_return([:A2])

        expect(solutions_calculator.second_move_recommendation).to eq(:A2)
      end
    end

    context 'after the second move' do
      it 'knows if it can win' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([:A1])

        expect(solutions_calculator.any_opportunity_to_win?).to be true
      end

      it 'knows if it cannot win' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([])

        expect(solutions_calculator.any_opportunity_to_win?).to be false
      end

      it 'can make a recomandation to win' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([:A1])

        expect(solutions_calculator.recommend_winning_solution).to eq(:A1)
      end

      it 'will recommend to win first if possible' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([:A1])

        expect(solutions_calculator.recommendation).to eq(:A1)
      end

      it 'recommned to defend if cant win and has to defend' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([])
        allow(solutions_calculator).to receive(:defending_solutions).and_return([:A1])

        expect(solutions_calculator.recommendation).to eq(:A1)
      end

      it 'recommends a random coordinate otherwise' do
        allow(solutions_calculator).to receive(:winning_solutions).and_return([])
        allow(solutions_calculator).to receive(:defending_solutions).and_return([])
        allow(grid).to receive(:available_cells_coordinates).and_return([:A1])

        expect(solutions_calculator.recommendation).to eq(:A1)
      end
    end
  end
end
