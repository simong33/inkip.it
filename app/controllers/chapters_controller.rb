class ChaptersController < ApplicationController

  after_filter :verify_policy_scoped, only: :index

  def show
    @chapter = Chapter.find(params[:id])
    authorize @chapter

    @book = @chapter.book
    @user = @book.user

    @reaction = Reaction.new

    @inkers = @chapter.inkers

    @appearance = Appearance.new
    @characters_left = @chapter.book.characters - @chapter.characters
    @places_left = @chapter.book.places - @chapter.places

    gon.wordcount = @book.wordcount.to_s + ' / ' + @book.word_goal.to_s + ' mots'
    gon.word_goal_ratio = @book.word_goal_ratio
    gon.fetch_refresh_wordcount_url = "/books/" + @book.id.to_s + "/chapters/" + @chapter.id.to_s + "/refresh_wordcount"

    gon.inks = @chapter.inks
    gon.user_inks = @chapter.inks_by(current_user) + 1

  end

  def create
    @chapter = Chapter.new(chapter_params)
    book = Book.find(params[:book_id])
    @chapter.book = book
    authorize @chapter

    if @chapter.save
      redirect_to book_chapter_path(book, @chapter), alert: "Vous avez ajouté un nouveau chapitre !"
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    authorize @chapter

    @chapter.update(chapter_params)

    respond_to do |format|
      format.js
      format.html { redirect_to action: "show" }
    end

  end

  def destroy
    book = Book.find(params[:book_id])
    @chapter = Chapter.find(params[:id])
    authorize @chapter

    @chapter.destroy

    redirect_to book_path(book)
  end

  def refresh_wordcount
    book = Book.find(params[:book_id])
    @word_goal_ratio = book.word_goal_ratio

    render json: @word_goal_ratio
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :content, :published)
  end
end
