class AppearancesController < ApplicationController

  def create
    @appearance = Appearance.new
    @appearance.chapter = Chapter.find(params[:chapter_id])
    @appearance.character = Character.find(params[:appearance][:character])
    @appearance.place = Place.find(params[:appearance][:place])
    if @appearance.save
      redirect_to book_chapter_path(@appearance.chapter.book, @appearance.chapter), alert: "Vous avez ajouté un nouveau personnage à ce chapitre!"
    end
  end
end
