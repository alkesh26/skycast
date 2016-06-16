RSpec.describe Validator::BlockedChannel, type: :class do

  before(:each) do
    @correct_channel = Channel.new(lowest_channel: 100, highest_channel: 988, blocked_channels: [191, 112, 451, 168])
    @incorrect_channel = Channel.new(lowest_channel: 100, highest_channel: 988, blocked_channels: [1, 19, 12, 45, 68, 1000])
    @incorrect_blocked_channel_size = 5
  end

  describe 'it should raise error' do

    it 'should raise count mismatch for blocked_channels' do
      expect{ Validator::BlockedChannel.new(@incorrect_blocked_channel_size, @correct_channel).validate }.to raise_error(StandardError, 'Count mismatch for blocked channels or size of blocked channels exceeds 40')
    end

    it 'should raise count mismatch for blocked_channels' do
      expect{ Validator::BlockedChannel.new(6, @incorrect_channel).validate }.to raise_error(StandardError, 'Blocked channel include channel numbers not present in channel list')
    end
  end

  describe 'it should not raise any error' do

    it 'is a valid list of blocked channels' do
      expect{ Validator::BlockedChannel.new(4, @correct_channel).validate }.not_to raise_error
    end
  end
end