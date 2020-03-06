class PublishSns
  def initialize
  end

  def exec
    params = {
      topic_arn: "arn:aws:sns:ap-northeast-1:934352308465:topic",
      message: "message hoge hoge hoge",
      subject: "subject",
      message_attributes: {
        aaa: { data_type: 'Binary', binary_value: [ 2, 3, 4 ].pack('C*') },
        ccc: { data_type: 'String', string_value: 'test' },
        zzz: { data_type: 'Number', string_value: '0230.01' },
        ary: { data_type: "String.Array", "string_value"=>"[\"hoge\", \"moge\"]" }
      }
    }
binding.pry
    sns_client.publish(params)
  end

  private

  def sns_client
    @sns_client ||= ::Aws::SNS::Client.new(sns_configuration)
  end

  def sns_configuration
    {
      access_key_id: ::Settings.aws_sns_access_key_id,
      secret_access_key: ::Settings.aws_sns_secret_access_key,
      region: ::Settings.aws_sns_region
    }
  end
end

PublishSns.new.exec
