require_relative '../lib/tic_tac_toe'

describe Game do
  
  subject(:winner) { described_class.new }

  describe '#check_win' do
    context 'when player gets 3 in a row @game_over == true' do
      context 'horizontal win'
        before do
          allow(winner).to receive(:check_win).with(player)
          allow(player).to receive(:marker).and_return(d)
      end
      let(:top_row_win) { instance_double (winner.display = %[d d d 4 5 6 7 8 9])}
      it 'top row results in game over' do
        expect(winner.check_win).to be_truthy
      end
    end
  end
       

end