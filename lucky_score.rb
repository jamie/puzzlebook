require 'lib/word_dictionary'

class LuckyScore
  attr_reader :words, :total_score
  
  def initialize(values, word_multipliers, dict_words)
    @values = values
    @words = word_multipliers.map{|wm|LuckyScoreWord.new(values, wm)}
    @dict_words = dict_words
    @total_score = 0
  end
  
  def run!
    answers = []
    @words.each do |word|
      words_and_scores = (@dict_words[word.size]-answers).map do
        |dict_word|
        [dict_word, word.score_for(dict_word)]
      end
      sorted = words_and_scores.sort{|a,b| b[1] <=> a[1]}
      answer, points = sorted[0]
      @total_score += points
      answers << answer
      puts "%s: %d" % [answer, points]
    end
  end
  
end

class LuckyScoreWord
  def initialize(letter_values, position_multipliers)
    @letter_values = letter_values
    @position_multipliers = position_multipliers
  end
  
  def value_for(letter)
    @letter_values[letter[0] - 'a'[0]]
  end
  
  def score_for(word)
    letters = word.split(//)
    values = letters.map{|letter|value_for(letter)}
    [@position_multipliers,values].transpose.map{|a,b|a*b}.inject{|a,b|a+b}
  end
  
  def size
    @position_multipliers.size
  end
end

#         A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
values = [6,3,1,2,6,1,4,5,3,1,2,5,3,5,7,3,2,3,7,4,4,2,1,2,4,1]

words = [[1,2,1,3,1,2,1],
         [2,1,2,1,1,1],
         [1,1,1,2,3],
         [3,1,2,1,1,1],
         [1,1,3,1,1,2,2],
         [2,1,2,1,3,1,1,1],
         [1,1,3,1,1,1],
         [3,1,1,3,1],
         [1,3,1,1,1,2,3],
         [1,2,1,1,3,1,1]]

dict_words = WordDictionary.new
ls = LuckyScore.new(values, words, dict_words)
ls.run!

puts "Total: #{ls.total_score}"
