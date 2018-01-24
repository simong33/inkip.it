class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user

    @book = @user.books.last


    @followers = @user.followers
    @followings = @user.following

    if @user.has_written?
      gon.wordcount_ratio = @book.wordcount.to_f / (@book.word_goal.to_f)
      @books = @user.books
      @chapters = @user.chapters
      @max_streaks = @book.max_streaks
      @words_per_session = @book.words_per_session
    else
      @max_streaks = 0
      @words_per_session = 0
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      redirect_to user_path(@user), alert: "Vous avez modifié votre profil !"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :profile_picture, :location)
  end
end
