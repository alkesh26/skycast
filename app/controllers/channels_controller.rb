class ChannelsController < ApplicationController

  def get_count
    channel = Validator::Channel.new(required_params).validate_and_get_channel
    minimum_count = Compute.new(channel).minimum_clicks
    render json: { minimum_count: minimum_count }, status: :ok
  end

  private

  def required_params
    params.permit(:lowest_channel, :highest_channel, :blocked_channel_size, :blocked_channels, :browsing_channel_size,
                  :browsing_channels)
  end
end
