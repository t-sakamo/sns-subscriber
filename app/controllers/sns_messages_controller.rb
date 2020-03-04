class SnsMessagesController < ApplicationController
  def index
    logger.debug "entering."
    @sns_messages = SnsMessage.all
  end
end
