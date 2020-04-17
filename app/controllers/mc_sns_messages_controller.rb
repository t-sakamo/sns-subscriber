class McSnsMessagesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.info("request_body: #{request_body}")
    logger.info("request_body: #{request_body}")
    logger.info("body_params: #{body_params}")
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

  # メッセージを処理する
  def process_sns_message
    logger.info("body_params[Message]: #{body_params["Message"]}")
    logger.info("sns_message[close] = #{sns_message['close']}")
    logger.info("sns_message[training] = #{sns_message['training']}")

    # close or training がtrueの場合は現行仕様に則り、何もしない
    return if sns_message['close']=='true' || sns_message['training']=='true'

    # すでに処理済みのメッセージは処理しない(冪等性)
    sns_message['key']
    sns_message['message_send_at']

    ##ActiveRecord::Base.transaction do
      restaurant = update_restaurant_contract(sns_message)
      # logを生成する
      body_params['TopicArn']
      sns_message.to_json
      sns_message['message_send_at']

      # 先行にlogが存在する場合は含めて実行する(順序性)
      sns_message['message_send_at'].to_i
    ##end
  end

  # restaurantとcontractingを作成(更新)する
  def update_restaurant_contract(message)
    logger.info("message class: #{message.class}")
    logger.info("message: #{message}")
    update_restaurant(message)
    message[:restaurant_optional_contracts]&.each do |key, val|
      if val == 'nil'
        nil
      else
        {
          start_at: str_to_datetime(val["start_at"]),
          end_at:  str_to_datetime(val["end_at"])
        }
      end
    end
  end

  # restaurantを作成(更新)する
  def update_restaurant(params)
    {
      name: params['name'],
      timezone: params['timezone'],
      order_index: params['order_index']
    }
  end

  def str_to_datetime(str)
    str = (str == 'nil') ? nil : str
    str.blank? ? nil : str.to_datetime
  end

  def sns_message
    @sns_message ||= JSON.parse(body_params["Message"])
  end
end
