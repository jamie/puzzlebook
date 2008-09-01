class WordDictionary
  def initialize(wordfile = nil)
    wordfile ||= File.dirname(File.expand_path(__FILE__))+"/sowpods-2-8.txt"
    @words = File.read(wordfile).split("\n")
  end
  
  def [](length)
    @words.select{|word| word.length == length}
  end
end
