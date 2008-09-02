require 'lib/word_dictionary'
d = WordDictionary.new("/usr/share/dict/words")

letters = gets.chomp.split(//)
gets.to_i.times do
  pattern = gets.chomp
  pattern.gsub!('.', "[#{letters.join}]")
  words = d[Regexp.new("^#{pattern}$")]
  letters.each do |letter|
    words.reject!{|word| word !~ /#{letter}/}
  end
  puts words
end

# RED

# T__A_
# T_N___
# D_S__T
# A____SS
# __SI__NT
# V__IFI__
# W_I__N_SS

