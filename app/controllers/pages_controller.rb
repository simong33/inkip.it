class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :rankings, :privacy_policy, :tos]

  def landing
  end

  def rankings
    books = Book.where('max_daily_wordcount > 0').order(max_daily_wordcount: :desc)

    most_written_books = books.limit(10)

    @best_authors = []

    most_written_books.each do |book|
      @best_authors << [book.user, book.max_daily_wordcount]
    end

  end

  def privacy_policy
  end

  def tos
  end
end
