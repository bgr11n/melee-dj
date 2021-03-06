module Parties
  class MessagesController < ApplicationController
    before_action :authenticate!
    before_action :find_chat

    def create
      build_message
      save_message || render(json: { success: false })
    end

  private

    def build_message
      @message ||= Chat::Message.new message_params.merge(user_id: current_user.id, chat_id: @chat.id)
    end

    def save_message
      bloadcast_message if @message.save
    end

    def bloadcast_message
      FayeClient::Broadcaster.publish "/#{@dj.nickname}/chat/messages/new", [@message]
      render json: { success: true }
    end

    def find_chat
      @chat = Party::Chat.includes(:messages, :party).find(params[:chat_id]) || not_found
      @dj = @chat.party.user
    end

    def message_params
      params[:chat_message] ? params[:chat_message].permit(:text) : {}
    end
  end
end
