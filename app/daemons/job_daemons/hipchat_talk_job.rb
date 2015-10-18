module JobDaemons
  class HipchatTalkJob < JobBase
    attr_reader :channel_id, :message, :color, :format, :notify

    def initialize(channel_id, name, message, color, format, notify)
      raise 'channel_id should be kind of String' unless channel_id.kind_of?(String)
      raise 'name should be kind of String' unless name.kind_of?(String)
      raise 'message should be kind of String' unless message.kind_of?(String)
      raise 'color should be kind of String' unless color.kind_of?(String)
      raise 'format should be kind of String' unless format.kind_of?(String)

      @channel_id = channel_id
      @name = name
      @message = message
      @color = color
      @format = format
      @notify = notify
    end

    def execute!
      HipchatUtils::SingletonClient.instance.send_message(@channel_id, @name, @message, @color, @format, @notify)
    end
  end
end
