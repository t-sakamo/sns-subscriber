class SnsMessagesController < ApplicationController

  def index
    logger.info("=== entering ===")
    @sns_messages = SnsMessage.all
  end

  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.info(request.headers.to_s)
  end
end
