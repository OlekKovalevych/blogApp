# frozen_string_literal: true

class ArticleService
  SEARCH_STRINGS = %w[frontend backend qa developer].freeze
  STRING_FOR_CAPITALIZE = %w[ruby rails].freeze
  # frontend, backend, qa, developer

  def check_title_and_body(article)
    article.title = refactor_string(article.title)
    article.body = refactor_string(article.body)
    article
  end

  private

  def refactor_string(string)
    buffer = string.split(' ')
    buffer.each do |word|
      word.capitalize! if STRING_FOR_CAPITALIZE.include?(word)
    end
    buffer -= SEARCH_STRINGS
    buffer.join(' ')
  end
end
