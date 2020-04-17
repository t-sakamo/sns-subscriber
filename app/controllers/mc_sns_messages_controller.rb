class McSnsMessagesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create
    str = "{\"key\":\"0123456789ABCDEF0123456789ABCDEF0\",\"close\":\"false\",\"training\":\"false\",\"name\":\"1\",\"timezone\":\"Asia/Tokyo\",\"order_index\":\"0\",\"restaurant_optional_contracts\":{\"medium_controller\":{\"start_at\":\"2019-05-21 15:00:00 UTC\",\"end_at\":\"nil\"},\"mail_importer\":{\"start_at\":\"2019-05-21 15:00:00 UTC\",\"end_at\":\"nil\"}},\"message_send_at\":\"15851018410503655\"}"

#    message = JSON.parse(body_params['Message'])
    message = JSON.parse(str)

    logger.debug("message.class = #{message.class}")

    logger.debug("key: #{message["key"]}")
    logger.debug("close: #{message["close"]}")
    logger.debug("training: #{message["training"]}")
    logger.debug("name: #{message["name"]}")
    logger.debug("timezone: #{message["timezone"]}")
    logger.debug("order_index: #{message["order_index"]}")

#\"restaurant_optional_contracts\":{\"medium_controller\":{\"start_at\":\"2019-05-21 15:00:00 UTC\",\"end_at\":\"nil\"},\"mail_importer\":{\"start_at\":\"2019-05-21 15:00:00 UTC\",\"end_at\":\"nil\"}},\"message_send_at\":\"15851018410503655\"}"

    return head 204

    case body_params["Type"].to_sym
    when :SubscriptionConfirmation
      confirm_subscription
    when :Notification
      process_sns_message
    end
    head 204
  end

  private

  def sns_message_authenticate
    # TopicArnと突合
    # 省略

    # Signatureをチェックする
    unless sns_message_verifier.authentic?(request_body)
      logger.error("SNS message signature is invalid. signature: #{body_params['Signature']}")
      return respond_error(:CONTRACT_MESSAGE_NOT_AUTHENTICATED, 401)
    end
  end

  def match_topic_arn?
    body_params['TopicArn'] == Settings.sns.contract_topic_arn
  end

  def sns_message_verifier
    @sns_message_verifier ||= Aws::SNS::MessageVerifier.new
  end

  def request_body
    @request_body ||= request.body.read
  end

  def body_params
    @body_params ||= JSON.parse(request_body)
  end

  def confirm_subscription
    http_get(body_params["SubscribeURL"])
  end

  def http_get(url)
    Faraday.get(url)
  end
end
