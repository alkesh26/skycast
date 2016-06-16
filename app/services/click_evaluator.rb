class ClickEvaluator

  MAX_CLICKS = 999999999
  attr_reader :current_channel_number, :previous_channel_number, :previous_of_previous_channel_number,
              :channel_distances, :highest_channel

  def initialize(params)
    @current_channel_number = params[:current_channel_number]
    @previous_channel_number = params[:previous_channel_number]
    @previous_of_previous_channel_number = params[:previous_of_previous_channel_number]
    @channel_distances = params[:channel].channel_distances
    @highest_channel = params[:channel].highest_channel
  end

  def clicks
    return 0 if previous_equals_current_channel?
    return 1 if previous_of_previous_equals_current_channel?
    [distance_between_channels(previous_channel_number), size_of_current_channel, previous_distance].min
  end

  private

  def previous_equals_current_channel?
    previous_channel_number == current_channel_number
  end

  def previous_of_previous_equals_current_channel?
    previous_of_previous_channel_number == current_channel_number
  end

  def distance_between_channels(previous_channel_number)
    [forward_distance(previous_channel_number), backward_distance(previous_channel_number)].min
  end

  def forward_distance(previous_channel_number)
    if current_channel_number > previous_channel_number
      channel_distances[current_channel_number] - channel_distances[previous_channel_number]
    else
      channel_distances[highest_channel] - channel_distances[previous_channel_number] +
      channel_distances[current_channel_number] + 1
    end
  end

  def backward_distance(previous_channel_number)
    if current_channel_number > previous_channel_number
      channel_distances[previous_channel_number] + channel_distances[highest_channel] -
      channel_distances[current_channel_number] + 1
    else
      channel_distances[previous_channel_number] - channel_distances[current_channel_number]
    end
  end

  def size_of_current_channel
    current_channel_number.to_s.size
  end

  def previous_distance
    previous_of_previous_channel_number.nil? ? MAX_CLICKS :
                                               distance_between_channels(previous_of_previous_channel_number) + 1
  end
end