class SnsMessagesController < ApplicationController
  def index
    @sns_messages = SnsMessage.all
  end
end
