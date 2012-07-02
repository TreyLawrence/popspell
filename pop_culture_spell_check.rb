require 'net/http'

class SpellChecker
  REGEX_FIND = /(Showing results for)[^>]+>[^.]+/
  REGEX_REMOVE = /(Showing results for <a[^>]+>)|(<b>)|(<i>)|(<\/b>)|(<\/i>)|(<\/a>)/
  
  def correct string
    @input_string = string
    if @input_string.length < 100
      result = Net::HTTP.get(URI.parse("http://www.google.com//search?sourceid=chrome-instant&q=#{@input_string.split.join('%20')}"))
      # Testing result
      # file = File.new("test.html", "w+")
      # file.write(result)
      find_string = result[REGEX_FIND]
      @no_corrections = find_string.nil?
      @corrected_string = @no_corrections ? "" : find_string.gsub(REGEX_REMOVE,"")
    end
    
    @corrected_string
  end
end

spelling = SpellChecker.new
puts spelling.correct(gets.chomp)