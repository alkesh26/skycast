RSpec.describe Validator::BrowsingChannel, type: :class do

  before(:each) do
    @incorrect_channel = Channel.new(lowest_channel: 1, highest_channel: 988, blocked_channels: [191, 112, 451, 168], browsing_channels: [])
    @correct_channel = Channel.new(lowest_channel: 100, highest_channel: 988, browsing_channels: [100, 190, 120, 450, 680, 100], blocked_channels: [])
    @incorrect_browsing_channel = Channel.new(lowest_channel: 100, highest_channel: 988, browsing_channels: [1, 19, 120, 45, 680, 100], blocked_channels: [])
    @incorrect_browsing_blocked_channel = Channel.new(lowest_channel: 1, highest_channel: 988, browsing_channels: [1, 19, 12, 45, 68, 100],
                                                       blocked_channels: [19, 75, 71])
    @incorrect_browsing_channel_size = 5
  end

  describe 'it should raise error' do

    it 'should raise count mismatch for browsing channel' do
      expect{ Validator::BrowsingChannel.new(@incorrect_browsing_channel_size, @incorrect_channel).validate }.to raise_error(StandardError, 'Count mismatch for browsing channels or size of browsing channels not in between 1 to 50')
    end

    it 'should raise count mismatch for browsing channel' do
      expect{ Validator::BrowsingChannel.new(6, @incorrect_browsing_channel).validate }.to raise_error(StandardError, 'Browsing channel include channel number not present in channel list')
    end

    it 'should raise browsing channel to not include blocked channel' do
      expect{ Validator::BrowsingChannel.new(6, @incorrect_browsing_blocked_channel).validate }.to raise_error(StandardError, 'Browsing channel should not include blocked channel number')
    end
  end

  describe 'it should not raise any error' do

    it 'should not raise any error' do
      expect{ Validator::BrowsingChannel.new(6, @correct_channel).validate }.not_to raise_error
    end
  end
end