class WordDictionary
  def initialize(wordfile = nil)
    wordfile ||= File.dirname(File.expand_path(__FILE__))+"/sowpods-2-8.txt"
    @words = File.read(wordfile).split("\n")
  end
  
  def [](filter)
    case filter
    when Fixnum
      @words.select{|word| word.length == length}
    when Regexp
      @words.select{|word| word =~ filter}
    else
      []
    end
  end
end
