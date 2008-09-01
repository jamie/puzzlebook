require 'lib/word_dictionary'

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

score = 0

dict_words = WordDictionary.new

def word_score(mult, values, word)
  letters = word.split(//)
  letter_values = letters.map{|l|values[l[0]-'a'[0]]}
  [mult,letter_values].transpose.map{|a,b|a*b}.inject{|a,b|a+b}
end

answers = []
words.each do |word|
  words_and_scores = (dict_words[word.size]-answers).map do
    |dict_word|
    [dict_word, word_score(word,values,dict_word)]
  end
  sorted = words_and_scores.sort{|a,b| b[1] <=> a[1]}
  answer, points = sorted[0]
  score += points
  answers << answer
  puts "%s: %d" % [answer, points]
end

puts "Total: #{score}"
