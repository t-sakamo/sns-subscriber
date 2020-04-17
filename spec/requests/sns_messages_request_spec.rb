require 'rails_helper'

RSpec.describe 'SnsMessages', type: :request do

  describe 'GET /sns_messages' do
    let(:sns_message) do
      create(:sns_message,
             body: "this is test message",
             message_attributes: "{\"aaa\":{\"Type\":\"Binary\",\"Value\":\"AgME\"},\"ccc\":{\"Type\":\"String\",\"Value\":\"test\"},\"ary\":{\"Type\":\"String.Array\",\"Value\":\"[\\\"hoge\\\", \\\"moge\\\"]\"},\"zzz\":{\"Type\":\"Number\",\"Value\":\"0230.01\"}}"
            )
    end

    before do
      get '/sns_messages'
    end

    it do
    end
  end

  describe 'POST /sns_messages' do

    before do
      post '/sns_messages', headers: request_header, params: request_body.to_json
    end

    describe "SNS SubscriptionConfirmation message" do
      let(:request_header) do
        {
          'x-amz-sns-message-type': 'Notification',
          'x-amz-sns-message-id': '165545c9-2a5c-472c-8df2-7ff2be2b3b1b',
          'x-amz-sns-topic-arn': 'arn:aws:sns:us-west-2:123456789012:MyTopic',
          'x-amz-sns-subscription-arn':
            'arn:aws:sns:us-west-2:123456789012:MyTopic:2bcfbf39-05c3-41de-beaa-fcfcc21c8f55',
          'Content-Type': 'text/plain; charset=UTF-8',
          'User-Agent': 'Amazon Simple Notification Service Agent'
        }
      end

      let(:request_body) do
        {
          "Type": "SubscriptionConfirmation",
          "TopicArn": "arn:aws:sns:ap-northeast-1:934352308465:topic",
          "Message": "You have chosen to subscribe to the topic arn:aws:sns:ap-northeast-1:934352308465:topic.\nTo confirm the subscription, visit the SubscribeURL included in this message.",
          "SubscribeURL": "https://sns.ap-northeast-1.amazonaws.com/?Action=ConfirmSubscription&TopicArn=arn:aws:sns:ap-northeast-1:934352308465:topic&Token=2336412f37fb687f5d51e6e2425f004aea431725ab141f407f8a425ec5fb9ad512d71844774643cf96089016b0b461e3821a9c4bb373edc5edf124468d3cbae0e600a161d446af893dddfd3eec13a72e42ad73a5e0bbc7e7e7e6c702107b2f61fb91bb2e3ddf1182718022472eacc3bc",
          "Timestamp": "2020-03-04T17:42:56.520Z",
          "SignatureVersion": "1",
          "Signature": "T1eR4hHkM7yOUPDei3aEon48j77O05zNisMokQ8578kbmh+rLiGqoGWChnSwTas6pu+tBrjgPBOx6iky9MJ04RgmIauq0dZ/wDaHTm+0VKv/zubB/A4nU6I0NtWtPrWoc6DX+ApGOmbZTUK8GDkF+SXHYQULU5kagz7fUWvgq7aXR3FhzWGqvOsNNfGvAuIy2Fp1QNoRaejwUkJw/Xzv//4HNmd2E1EuV3ETVyphVs7ndjhawaSEKfywdyGL40dMSdKSGEYOCbKti2dc6nuw0asRS/G5WLRk8wnmmLbVNXr7hW3JWN2x9Jdq1djDVWex20WTZpCFCClKYpLTuTvbTA==",
          "SigningCertURL": "https://sns.ap-northeast-1.amazonaws.com/SimpleNotificationService-a86cb10b4e1f29c941702d737128f7b6.pem"
        }
      end

      it do
      end
    end

    describe "SNS Notification message" do
      let(:request_header) do
        {
          'HTTP_X_AMZ_SNS_MESSAGE_TYPE': 'Notification',
          'HTTP_X_AMZ_SNS_MESSAGE_ID': 'a28aa186-58f8-5bdb-b1e8-f75c984940e5',
          'HTTP_X_AMZ_SNS_TOPIC_ARN': 'arn:aws:sns:ap-northeast-1:934352308465:topic',
          'HTTP_X_AMZ_SNS_SUBSCRIPTION_ARN': 'arn:aws:sns:ap-northeast-1:934352308465:topic:7b0449a3-5174-47d6-97b7-db51a2ffe51e',
          'CONTENT_TYPE': 'text/plain; charset=UTF-8',
          'HTTP_USER_AGENT': 'Amazon Simple Notification Service Agent'
        }
      end

      let(:request_body) do
        {
          Type: "Notification",
          MessageId: "a28aa186-58f8-5bdb-b1e8-f75c984940e5",
          TopicArn: "arn:aws:sns:ap-northeast-1:934352308465:topic",
          Subject: "this is test",
          Message: "this is test message\n{\n  hoge: \"moge\"\n}",
          MessageAttributes: {"aaa"=>{"Type"=>"Binary", "Value"=>"AgME"}, "ccc"=>{"Type"=>"String", "Value"=>"test"}, "ary"=>{"Type"=>"String.Array", "Value"=>"[\"hoge\", \"moge\"]"}, "zzz"=>{"Type"=>"Number", "Value"=>"0230.01"}},
          Timestamp: "2020-03-05T08:55:13.482Z",
          SignatureVersion: "1",
          Signature: "o5qOvMyr+L6satX88jC3TAmOlRPSO8KcJb2zLKz+uUR/8YJdHr6qBAfOSbw1UcTDukE4HQJDe7yomQZqYTQW4OMUXnudUk+c45YqNQrCNGwQ6KQYC7Ord2ANSciGj62mxX3tRZgOqmwvkLGryNrPdPAYXBIIeLFSnz8uKE4wQTuLcQIMchrUmM6t4KPUmMPbakSZvGgz7adtegYy0+ziiqLEmWHhmH0MIgVtgH4p7IGrF2S1dtkWtagnHuW/qwztVYQnwCAvoiebOohKj8LLSIY46wqjR4qNC1Q5VPvcfSSImGP94q6+wgamDdvhNLp2h404gtFaNWDM86uEkwfTVQ==",
          SigningCertURL: "https://sns.ap-northeast-1.amazonaws.com/SimpleNotificationService-a86cb10b4e1f29c941702d737128f7b6.pem",
          UnsubscribeURL: "https://sns.ap-northeast-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:ap-northeast-1:934352308465:topic:7b0449a3-5174-47d6-97b7-db51a2ffe51e"
        }
      end

      it do
      end
    end
  end
end

