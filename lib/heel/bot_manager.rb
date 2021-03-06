module Heel
  class BotManager

    BOT_CONF_NAME = "heelspec/bots.yaml"

    @new_conf = false

    attr_reader :bot_list

    def initialize
      @bot_list ||= []
      load_bots
    end

    def add_bot(bot_name)
    end

    def remove_bot(bot_name)
    end

    def run_bot(bot_name, bot_cmd)
      require_relative "../../heelspec/#{bot_name}"
      bot_class_name = bot_name_to_class_name(bot_name)
      bot_class = eval("Heelspec::#{bot_class_name}")
      bot = bot_class.new
      bot.run(bot_cmd)
    end

    private

    def load_bots
      if File.exists? BOT_CONF_NAME
        @new_conf = false;
        @bot_list = YAML.load_file BOT_CONF_NAME
      else
        @new_conf = true
        f = File.new(BOT_CONF_NAME, "w")
        f.close
      end
    end

    def bot_name_to_class_name(bot_name)
      ary_bot_name = bot_name.split "_"
      class_name = ""
      ary_bot_name.each do |name_part|
        class_name << name_part.capitalize
      end
      class_name
    end

  end
end