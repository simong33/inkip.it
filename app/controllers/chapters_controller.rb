class ChaptersController < ApplicationController

  def show
    @chapter = Chapter.find(params[:id])
    @book = @chapter.book
    @appearance = Appearance.new
    @characters_left = @chapter.book.characters - @chapter.characters
    @places_left = @chapter.book.places - @chapter.places
  end

  def create
    @chapter = Chapter.new(chapter_params)
    book = Book.find(params[:book_id])
    @chapter.book = book
    if @chapter.save
      redirect_to book_chapter_path(book, @chapter), alert: "Vous avez ajouté un nouveau chapitre!"
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)

    redirect_to book_chapter_path(@chapter.book, @chapter)
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :content)
  end
end
