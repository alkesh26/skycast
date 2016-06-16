RSpec.describe Compute do

  before(:each) do
    @channel1 = Channel.new(lowest_channel: 1, highest_channel: 100, blocked_channel_size: 4, browsing_channel_size: 8,
                            blocked_channels: [78, 79, 80, 3], browsing_channels: [10, 13, 13, 100, 99, 98, 77, 81])
    @channel2 = Channel.new(lowest_channel: 1, highest_channel: 10, blocked_channel_size: 1, browsing_channel_size: 4,
                            blocked_channels: [4], browsing_channels: [1, 10, 3, 5])
  end

  describe 'compute class' do

    it 'it should return count' do
      min_clicks = Compute.new(@channel1).minimum_clicks
      expect(min_clicks).to eq(12)
    end

    it 'for round robin case should return correct result' do
      min_clicks = Compute.new(@channel2).minimum_clicks
      expect(min_clicks).to eq(4)
    end
  end
end