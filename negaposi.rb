#! /usr/bin/env ruby
# coding: utf-8

class NegaPosi
  require 'bundler/setup'
  require 'natto'
  require 'open-uri'

  def create_dictionary
    url = "http://www.lr.pi.titech.ac.jp/~takamura/pubs/pn_ja.dic"
    dictionary = {}
    open(url) do |f|
      f.each_line do |l|
        line_arr = l.encode("UTF-8", "Shift_JIS").gsub(/\r\n/, "").split(":")
        dictionary[line_arr[0]] = line_arr[3]
        dictionary[line_arr[1]] = line_arr[3]
      end
    end
    dictionary
  end

  def score_of(word)
    @dictionary ||= create_dictionary
    @dictionary[word].to_f || 0.0
  end

  def total_score_of(text)
    @dictionary ||= create_dictionary
    natto         = Natto::MeCab.new
    scores        = []

    natto.parse(text) do |n|
      puts "#{n.surface}\t#{n.feature}"
      if @dictionary.has_key?(n.surface)
        scores << score_of(n.surface)
      end
    end
    scores.empty? ? 0.0 : scores.inject(:+) / scores.count
  end

end

# s = NegaPosi.total_score_of(text)
# puts "#{text}"
# puts "    => Score : #{s}"
n = NegaPosi.new
while text = STDIN.gets
  s = n.total_score_of(text) if text.is_a?(String)
  puts "    => Score : #{s}"
end
