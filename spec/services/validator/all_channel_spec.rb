RSpec.describe Validator::AllChannel, type: :class do

  before(:each) do
    @incorrect_lowest_channel = Channel.new(lowest_channel: -1, highest_channel: 100)
    @incorrect_highest_channel = Channel.new(lowest_channel: 1, highest_channel: 1000000)
    @correct_channel = Channel.new(lowest_channel: 100, highest_channel: 988)
  end

  describe 'it should raise error' do

    it 'should raise lowest incorrect channel error' do
      expect{Validator::AllChannel.new(@incorrect_lowest_channel).validate}.to raise_error(StandardError, 'Invalid lowest channel')
    end

    it 'should raise highest incorrect channel error' do
      expect{Validator::AllChannel.new(@incorrect_highest_channel).validate}.to raise_error(StandardError, 'Invalid highest channel')
    end
  end

  describe 'it should not raise any error' do

    it 'is correct channel' do
      expect{Validator::AllChannel.new(@correct_channel).validate}.not_to raise_error
    end
  end
end