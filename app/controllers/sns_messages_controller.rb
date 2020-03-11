class SnsMessagesController < ApplicationController

  def index
    logger.info("=== entering ===")
    @sns_messages = SnsMessage.all
  end

  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.debug("=== body ===")
    body_params.each {|k, v| logger.debug("#{k} : #{v}")}

    logger.debug("=== header ===")
    request.headers.env.each {|k, v| logger.debug("#{k} : #{v}")}

    authentic? ? logger.debug("authentic? is true") : logger.debug("authentic? is false")
    case body_params["Type"]
    when "SubscriptionConfirmation"
      confirm_subscription
    when "Notification"
      recieve_message
    end
  end

  private

  def request_body
    @request_body ||= request.body.read
  end

  def body_params
    @body_params ||= JSON.parse(request_body)
  end

  def authentic?
    # TopicArnと突合
    # 省略

    # Signatureをチェックする
    Aws::SNS::MessageVerifier.new.authentic?(request_body)
  end

  def confirm_subscription
    Faraday.get(body_params["SubscribeURL"])
  end

  def recieve_message
    logger.debug("==== body_params[MessageAttributes] ===")
    logger.debug(body_params["MessageAttributes"])
    SnsMessage.create(
      body: body_params["Message"]
#      message_attributes: body_params["MessageAttributes"].to_json
    )
  end
end
