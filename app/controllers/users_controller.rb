class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user

    @book = @user.books.last

    gon.wordcount_ratio = @book.wordcount.to_f / (@book.word_goal.to_f)
  end
end
