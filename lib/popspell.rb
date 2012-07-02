require 'net/http'

class PopSpell
  REGEX_FIND = /(Showing results for)[^>]+>[^.]+/
  REGEX_REMOVE = /(Showing results for <a[^>]+>)|(<b>)|(<i>)|(<\/b>)|(<\/i>)|(<\/a>)/
  
  def correct string
    @input_string = string.chomp
    if @input_string.length < 50
      result = Net::HTTP.get(URI.parse("http://www.google.com//search?sourceid=chrome-instant&q=#{@input_string.split.join('%20')}"))
      # Testing: view result of GET request
      # file = File.new("test.html", "w+")
      # file.write(result)
      find_string = result[REGEX_FIND]
      @no_corrections = find_string.nil?
      @corrected_string = @no_corrections ? "" : find_string.gsub(REGEX_REMOVE,"")
    else
      @corrected_string = "String limited to 50 characters"
    end
    
    @corrected_string
  end
end