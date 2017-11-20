class ChaptersController < ApplicationController
  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.book = Book.find(params[:book_id])
    if @chapter.save
      redirect_to book_path(@chapter.book), alert: "Vous avez ajouté un nouveau chapitre!"
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title)
  end
end
