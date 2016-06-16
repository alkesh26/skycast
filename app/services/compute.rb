class Compute

  attr_reader :channel
  attr_accessor :channel_distances, :min_clicks, :previous_channel_number, :previous_of_previous_channel_number

  def initialize(channel)
    @channel = channel
    @min_clicks = set_initial_min_clicks
    @channel_distances = channel.distances
    initialize_previous_channels
  end

  def minimum_clicks
    channel.browsing_channels.each do |current_channel_number|
      @min_clicks += ClickEvaluator.new(current_channel_number: current_channel_number,
                                        previous_channel_number: previous_channel_number,
                                        previous_of_previous_channel_number: previous_of_previous_channel_number,
                                        channel: channel).clicks
      @previous_of_previous_channel_number = previous_channel_number
      @previous_channel_number = current_channel_number
    end
    @min_clicks
  end

  private

  def set_initial_min_clicks
    first_channel = channel.browsing_channels.first
    @min_clicks = first_channel.to_s.length
  end

  def initialize_previous_channels
    @previous_channel_number = channel.browsing_channels.shift
  end

end