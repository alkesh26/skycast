module Validator
  class BlockedChannel

    attr_reader :blocked_channel_size, :blocked_channels, :all_channel_list

    def initialize(blocked_channel_size, channel)
      @blocked_channel_size = blocked_channel_size
      @blocked_channels = channel.blocked_channels
      @all_channel_list = channel.all_channel_list
    end

    def validate
      blocked_channel_input_valid?
      blocked_channels_within_channels_list?
    end

    private

    def blocked_channel_input_valid?
      unless blocked_channel_size == blocked_channels.size && blocked_channels.size <= 40
        raise StandardError, 'Count mismatch for blocked channels or size of blocked channels exceeds 40'
      end
    end

    def blocked_channels_within_channels_list?
      unless (blocked_channels - all_channel_list).empty?
        raise StandardError, 'Blocked channel include channel numbers not present in channel list'
      end
    end
  end
end