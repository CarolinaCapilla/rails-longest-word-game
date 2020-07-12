require "open-uri"


class GamesController < ApplicationController
 
  def new
  @letters = ('B'..'Z').to_a.sample(7)
  vowels = ['A','E','I','O','U'].sample(3)
  @letters += vowels
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
