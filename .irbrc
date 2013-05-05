# https://github.com/michaeldv/awesome_print#irb-integration

require "awesome_print"
AwesomePrint.irb!

class Object
  def methodz
    public_methods - Object.methods
  end

  def call_methodz
    methodz.each do |name|
      ap name
      if (argument_count = method(name).arity) == 0
        ap send(name)
      else
        puts "!!! #{argument_count} argument(s) needed"
      end
      puts puts
    end
  end
end

# http://quotedprintable.com/2007/6/9/irb-history-and-completion

require "irb/completion"
require "irb/ext/save-history"

ARGV.concat %w(--readline --prompt-mode simple)

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
