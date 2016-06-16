RSpec.describe ClickEvaluator do

  before(:each) do
    @channel = Channel.new(lowest_channel: 1, highest_channel: 100, blocked_channel_size: 4, browsing_channel_size: 9,
                            blocked_channels: [78, 79, 80, 3], browsing_channels: [10, 13, 13, 100, 1, 99, 98, 77, 81])
  end

  describe 'clicks' do

    it 'should return 0 if previous channel equals current channel' do
      click_counts = ClickEvaluator.new(current_channel_number: 87, previous_channel_number: 87, channel: @channel).clicks
      expect(click_counts).to eq(0)
    end

    it 'should return 1 if previous of previous channel equals current channel' do
      click_counts = ClickEvaluator.new(current_channel_number: 87, previous_of_previous_channel_number: 87, channel: @channel).clicks
      expect(click_counts).to eq(1)
    end

    it 'should return 1 for roll over channel' do
      @channel.distances
      click_counts = ClickEvaluator.new(current_channel_number: 1, previous_channel_number: 100, previous_of_previous_channel_number: 13, channel: @channel).clicks
      expect(click_counts).to eq(1)
    end
  end
end