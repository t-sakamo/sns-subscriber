class SnsMessagesController < ApplicationController

  def index
    logger.info("=== entering ===")
    @sns_messages = SnsMessage.all
  end

  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.debug("=== body ===")
    JSON.parse(request.body.read).tap do |body_params|
      body_params.each {|k, v| logger.debug("#{k} : #{v}")}
    end
    logger.debug("=== header ===")
    request.headers.env.each {|k, v| logger.debug("#{k} : #{v}")}
  end
end
