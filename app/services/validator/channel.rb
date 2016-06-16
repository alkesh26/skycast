module Validator
  class Channel

    attr_reader :lowest_channel, :highest_channel, :blocked_channels, :blocked_channel_size,
                :browsing_channels, :browsing_channel_size
    attr_accessor :channel

    def initialize(params)
      @lowest_channel = params[:lowest_channel].to_i
      @highest_channel = params[:highest_channel].to_i
      @blocked_channels = (params[:blocked_channels] || '').split(' ').map(&:to_i)
      @browsing_channels = (params[:browsing_channels] || '').split(' ').map(&:to_i)
      @blocked_channel_size = params[:blocked_channel_size].to_i
      @browsing_channel_size = params[:browsing_channel_size].to_i
    end

    def validate_and_get_channel
      create_channel
      valid_channel_range?
      valid_blocked_channels?
      valid_browsing_channels?
      fetch_channel
    end

    private

    def create_channel
      @channel = ::Channel.new(lowest_channel: lowest_channel,
                               highest_channel: highest_channel,
                               blocked_channels: blocked_channels,
                               browsing_channels: browsing_channels)
    end

    def valid_channel_range?
      AllChannel.new(channel).validate
    end

    def valid_blocked_channels?
      BlockedChannel.new(blocked_channel_size, channel).validate
    end

    def valid_browsing_channels?
      BrowsingChannel.new(browsing_channel_size, channel).validate
    end

    def fetch_channel
      channel
    end
  end

end