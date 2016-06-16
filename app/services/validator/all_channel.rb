module Validator
  class AllChannel

    LOWEST_CHANNEL_LIMIT = 1
    HIGHEST_CHANNEL_LIMIT = 10000

    attr_reader :lowest_channel, :highest_channel

    def initialize(channel)
      @lowest_channel = channel.lowest_channel
      @highest_channel = channel.highest_channel
    end

    def validate
      is_lower_limit_valid?
      is_higher_limit_valid?
    end

    private

    def is_lower_limit_valid?
      unless lowest_channel >= LOWEST_CHANNEL_LIMIT
        raise StandardError, 'Invalid lowest channel'
      end
    end

    def is_higher_limit_valid?
      unless highest_channel <= HIGHEST_CHANNEL_LIMIT && highest_channel >= lowest_channel
        raise StandardError, 'Invalid highest channel'
      end
    end
  end
end