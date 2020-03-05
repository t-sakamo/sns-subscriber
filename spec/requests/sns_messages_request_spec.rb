require 'rails_helper'

RSpec.describe 'SnsMessages', type: :request do
  describe 'POST /sns_messages#create' do

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

    before do
      post '/sns_messages', headers: request_header, params: request_body.to_json
    end

    it do
    end
  end
end

