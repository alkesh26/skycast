class Channel

  attr_reader :lowest_channel, :highest_channel, :blocked_channels, :browsing_channels
  attr_accessor :channel_distances

  def initialize(params)
    @lowest_channel = params[:lowest_channel]
    @highest_channel = params[:highest_channel]
    @blocked_channels = params[:blocked_channels]
    @browsing_channels = params[:browsing_channels]
    @channel_distances = Array.new(highest_channel + 1, 0)
  end

  def all_channel_list
    (lowest_channel..highest_channel).to_a
  end

  def distances
    channel_ranges.each do |channel_number|
      if is_not_blocked(channel_number)
        channel_distances[channel_number] = channel_distances[channel_number - 1] + 1
      else
        channel_distances[channel_number] = channel_distances[channel_number - 1]
      end
    end
  end

  private

  def channel_ranges
    ((lowest_channel+1)..highest_channel)
  end

  def is_not_blocked(channel_number)
    blocked_channels.index(channel_number).nil?
  end
end

