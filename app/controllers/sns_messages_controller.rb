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

    case body_params["Type"]
    when "SubscriptionConfirmation"
      confirm_subscription
    end
  end

  private

  def request_body
    @request_body ||= request.body.read
  end

  def body_params
    @body_params ||= JSON.parse(request_body)
  end

  def confirm_subscription
    return false unless check_confirm_subscription
    do_confirm_subscription
  end

  def check_confirm_subscription
    # TopicArnと突合
    # 省略

    # Signatureをチェックする
    ret = Aws::SNS::MessageVerifier.new.authentic?(request_body)
    logger.debug("verifier.authentic? is true") if ret
    logger.debug("verifier.authentic? is false") unless ret
    ret
  end

  def do_confirm_subscription
  end
end
