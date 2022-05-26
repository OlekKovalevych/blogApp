# frozen_string_literal: true

class ArticleService
  FORBIDDEN_WORDS = %w[frontend backend qa developer].freeze
  WORDS_FOR_CAPITALIZE = %w[ruby rails].freeze
  # frontend, backend, qa, developer

  def initialize(article:)
    @article = article
  end

  def call
    article.title = refactor_text(text: article.title)
    article.body = refactor_text(text: article.body)
    article
  end

  private

  attr_accessor :article

  def refactor_text(text:)
    text = text.split(' ')
    text = downcase(text) - FORBIDDEN_WORDS
    capitalize(text).join(' ')
  end

  def downcase(words)
    words.map(&:downcase)
  end

  def capitalize(words)
    words.map do |word|
      word_for_capitalize?(word) ? word.capitalize! : word
    end
  end

  def word_for_capitalize?(word)
    WORDS_FOR_CAPITALIZE[0].eql?(word.downcase) || WORDS_FOR_CAPITALIZE[1].eql?(word.downcase)
  end
end
