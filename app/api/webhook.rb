module Webhook
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
    post do
      # TODO: create message module
      message = params[:item][:message]
      Bot.where(channel: params[:item][:room][:id]).pluck(:id).each do |bot_id|
        JobDaemon.enqueue(JobDaemons::BotJob.new(bot_id, 'onTalk', [message[:from][:id].to_s, message[:message]]))
      end

      {}
    end
  end
end
