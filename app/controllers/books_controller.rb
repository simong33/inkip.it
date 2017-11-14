class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def index
    @books = current_user.books
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @book.save
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

end
