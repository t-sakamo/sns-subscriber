class SnsMessagesController < ApplicationController
  def index
    logger.info("=== entering ===")
    @sns_messages = SnsMessage.all
  end
end
