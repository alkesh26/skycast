RSpec.describe Validator::Channel, type: :class do

  before(:each) do
    @params = {lowest_channel: 100, highest_channel: 988, browsing_channels: '100 190 120 450 680 100', blocked_channels: '',
               blocked_channel_size: 0, browsing_channel_size: 6}
  end

  describe 'No validation should fail' do

    it 'should not raise any error and create channel' do
      result = Validator::Channel.new(@params).validate_and_get_channel
      expect(result.class).to eq(Channel)
      expect(result.lowest_channel).to eq(@params[:lowest_channel])
    end
  end

  describe 'it should raise error' do

    it 'should raise lowest channel error' do
      @params[:lowest_channel] = 0
      expect {Validator::Channel.new(@params).validate_and_get_channel}.to raise_error(StandardError, 'Invalid lowest channel')
    end

    it 'should raise lowest channel error' do
      @params[:highest_channel] = 1
      expect {Validator::Channel.new(@params).validate_and_get_channel}.to raise_error(StandardError, 'Invalid highest channel')
    end

    it 'should raise mismatch in blocked channel size' do
      @params[:blocked_channels] = '1'
      expect {Validator::Channel.new(@params).validate_and_get_channel}.to raise_error(StandardError, 'Count mismatch for blocked channels or size of blocked channels exceeds 40')
    end

    it 'should raise blocked channel should not be in browsing channel' do
      @params[:blocked_channels] = '100'
      @params[:blocked_channel_size] = 1
      expect {Validator::Channel.new(@params).validate_and_get_channel}.to raise_error(StandardError, 'Browsing channel should not include blocked channel number')
    end
  end
end