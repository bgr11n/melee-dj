module Parties
  class ChatController < ApplicationController
    before_action :authenticate!

  end
end
