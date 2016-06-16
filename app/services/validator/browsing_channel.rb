module Validator
  class BrowsingChannel

    MIN_NUMBER = 1
    MAX_NUMBER = 50

    attr_reader :browsing_channel_size, :browsing_channels, :all_channel_list, :blocked_channels

    def initialize(browsing_channel_size, channel)
      @browsing_channel_size = browsing_channel_size
      @browsing_channels = channel.browsing_channels
      @all_channel_list = channel.all_channel_list
      @blocked_channels = channel.blocked_channels
    end

    def validate
      browsing_channel_input_valid?
      browsing_channels_within_channels_list?
      browsing_channels_exclude_blocked_channels?
    end

    private

    def browsing_channel_input_valid?
      unless browsing_channel_size == browsing_channels.size && browsing_channel_size.between?(MIN_NUMBER, MAX_NUMBER)
        raise StandardError, 'Count mismatch for browsing channels or size of browsing channels not in between 1 to 50'
      end
    end

    def browsing_channels_within_channels_list?
      unless (browsing_channels - all_channel_list).empty?
        raise StandardError, 'Browsing channel include channel number not present in channel list'
      end
    end

    def browsing_channels_exclude_blocked_channels?
      unless (browsing_channels & blocked_channels).empty?
        raise StandardError, 'Browsing channel should not include blocked channel number'
      end
    end
  end
end