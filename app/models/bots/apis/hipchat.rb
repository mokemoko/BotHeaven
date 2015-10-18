module Bots::Apis
  class Hipchat
    def initialize(bot)
      @bot = bot
    end

    def notification(message, color="yellow", format="html", notify=false)
      JobDaemon.enqueue(JobDaemons::HipchatTalkJob.new(@bot.channel.to_s, @bot.name.to_s, message.to_s, color.to_s, format.to_s, notify))
      true
    rescue
      false
    end
  end
end
