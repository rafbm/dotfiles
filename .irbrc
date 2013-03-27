# https://github.com/michaeldv/awesome_print#irb-integration

require "rubygems"
require "awesome_print"
AwesomePrint.irb!

# http://quotedprintable.com/2007/6/9/irb-history-and-completion

require "irb/completion"
require "irb/ext/save-history"

ARGV.concat %w(--readline --prompt-mode simple)

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
