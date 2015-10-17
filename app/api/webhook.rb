module Webhook
  class API < Grape::API
    format :json

    desc 'Hipchat Webhook'
    params do
      requires :event, type: String
      optional :item, type: Hash do
        requires :message, type: Hash do
          requires :date, type: DateTime
          requires :message, type: String
        end
        requires :room, type: Hash do
          requires :id, type: Integer
        end
      end
    end
    post do
      puts params
    end
  end
end
