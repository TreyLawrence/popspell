require 'popspell'

spelling = PopSpell.new
puts "Example: My favorite beer is #{spelling.correct('Aekt Schlencherla Rauchbier')}"
print "Try your own: "
puts "Is corrected to: #{spelling.correct(gets)}"