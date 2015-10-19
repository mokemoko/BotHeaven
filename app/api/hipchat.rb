module Hipchat
  class API < Grape::API
    format :json

    desc 'Hipchat Webhook'
    params do
      requires :event, type: String
      requires :item, type: Hash do
        requires :message, type: Hash do
          requires :date, type: DateTime
          requires :from, type: Hash do
            requires :id, type: Integer
          end
          requires :message, type: String
        end
        requires :room, type: Hash do
          requires :id, type: Integer
        end
      end
    end
    post 'webhook' do
      # TODO: create message module
      message = params[:item][:message]
      Bot.where(channel: params[:item][:room][:id]).pluck(:id).each do |bot_id|
        JobDaemon.enqueue(JobDaemons::BotJob.new(bot_id, 'onTalk', [message[:from][:id].to_s, message[:message]]))
      end

      {}
    end

    desc 'Hipchat Add-On Callback'
    params do
      requires :capabilitiesUrl, type: String
      requires :oauthId, type: String
      requires :oauthSecret, type: String
      optional :roomId, type: String
    end
    post 'callback' do
      p params
      {}
    end
  end
end
