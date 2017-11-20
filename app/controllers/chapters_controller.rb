class ChaptersController < ApplicationController

  def show
    @chapter = Chapter.find(params[:id])
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.book = Book.find(params[:book_id])
    if @chapter.save
      redirect_to book_chapter_path(@chapter), alert: "Vous avez ajouté un nouveau chapitre!"
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)

    redirect_to book_chapter_path(@chapter)
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :content)
  end
end
