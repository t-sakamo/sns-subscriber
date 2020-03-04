require 'rails_helper'

RSpec.describe 'SnsMessages', type: :request do
  describe 'POST /sns_messages#create' do

    let(:headers) do
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

    before do
      post '/sns_messages', headers: headers
    end

    it do
    end
  end
end

