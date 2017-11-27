class PlacesController < ApplicationController
  def create
    @place = Place.new(place_params)
    @place.book = Book.find(params[:book_id])
    if @place.save
      redirect_to book_places_path(@place.book), alert: "Vous avez ajouté un nouveau lieu!"
    end
  end

  def index
    @book = Book.find(params[:book_id])
    @place = Place.new
    @characters = @book.characters
    @chapters = @book.chapters
    @places = @book.places
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end
end
