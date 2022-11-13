require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe Game do
  # subject(:game) { described_class.new }

  describe '#check_win' do
    # context 'when player gets 3 in a row @game_over == true' do
    context 'horizontal win'
    subject(:winner) { described_class.new }
    before do

      # allow(game).to receive(:check_win).with(player)
    end

    it 'top row results in game over' do
      player = double()
      allow(player).to receive(:marker).and_return('d')
      # allow(winner).to receive(:check_win).and_return(true)

      winner.display = [1, 2, 3, 'd', 'd', 'd', 7, 8, 9]
      result = winner.check_win(player)
      expect(result).to be_truthy
    end
    it 'middle row results in game over' do
      player = double()
      allow(player).to receive(:marker).and_return('d')
      # allow(winner).to receive(:check_win).and_return(true)

      winner.display = ['d', 'd', 'd', 4, 5, 6, 7, 8, 9]
      result = winner.check_win(player)
      expect(result).to be_truthy
    end
    it 'bottom row results in game over' do
      player = double()
      allow(player).to receive(:marker).and_return('d')
      # allow(top_row_win).to receive(:check_win).and_return(true)

      winner.display = [1, 2, 3, 4, 5, 6, 'd', 'd', 'd']
      result = winner.check_win(player)
      expect(result).to be_truthy
    end

  end
end
