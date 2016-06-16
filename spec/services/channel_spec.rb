RSpec.describe Channel, type: :class do

  before(:each) do
    @channel = Channel.new(lowest_channel: 1, highest_channel: 10, blocked_channels: [4, 6], browsing_channels: [1, 10, 5])
  end

  describe 'Channel class' do

    it 'should check for channel' do
      expect(@channel.lowest_channel).to eq(1)
      expect(@channel.highest_channel).to eq(10)
      expect(@channel.all_channel_list).to eq((1..10).to_a)
      expect(@channel.distances).to eq(2..10)
    end

  end
end