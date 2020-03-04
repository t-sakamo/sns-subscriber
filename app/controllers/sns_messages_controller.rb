class SnsMessagesController < ApplicationController

  def index
    logger.info("=== entering ===")
    @sns_messages = SnsMessage.all
  end

  skip_before_action :verify_authenticity_token, only: :create

  def create
    request.headers.env.each {|k, v| logger.debug("#{k} : #{v}")}
  end
end
