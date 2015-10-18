require 'hipchat'

module HipchatUtils
  class SingletonClient

    def self.instance
      @singleton_client_instance ||= new
    end

    def initialize
      token = Rails.application.secrets.hipchat_token
      server = Rails.application.secrets.hipchat_server || 'https://api.hipchat.com'
      @client = HipChat::Client.new(token, api_version: 'v2', server_url: server)
    end

    def send_message(channel_id, name, message, color, format, notify)
      client[channel_id].send(name, message, color: color, message_format: format, notify: notify)
    end

    private
    def client
      @client
    end

    private_class_method :new
  end
end
