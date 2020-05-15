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
  rescue JSON::ParserError => e
    logger.error("JSON parse error: #{e}")
    head 204
  end

  private

  def request_body
    @request_body ||= request.body.read
  end

  def body_params
    @body_params ||= JSON.parse(request_body)
  end

  def sns_message
    @sns_message ||= JSON.parse(body_params["Message"])
  end

  def message_attributes
    @message_attributes ||= body_params["MessageAttributes"]
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
    logger.info("entering!")
    logger.info("body_params: #{body_params}")
    logger.info("sns_message: #{sns_message}")
=begin
    logger.info("message_attributes: #{message_attributes}")

    ## MessageAttributes : {"string_value"=>{"Type"=>"String.Array", "Value"=>"[\"hogeeeeee\", \"moge\",  \"poge\"]"}}
    ## "string_array"=>{"Type"=>"String.Array", "Value"=>"[\"hoge\",\"moge\",\"poge\"]"}}
    msg_attr = JSON.parse(message_attributes["string_value"]["Value"])
    logger.info("string_array: #{msg_attr}")
    logger.info("class: #{msg_attr.class.name}")
=end
    logger.info("account_ids: #{sns_message['account_ids']}")
  end
end
