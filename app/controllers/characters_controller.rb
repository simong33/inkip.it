class CharactersController < ApplicationController
  def create
    @character = Character.new(character_params)
    @character.book = Book.find(params[:book_id])
    authorize @character

    if @character.save
      redirect_to book_characters_path(@character.book), alert: "Vous avez ajouté un nouveau personnage!"
    end
  end

  def show
    @character = Character.find(params[:id])
    authorize @character
  end

  def index
    @book = Book.find(params[:book_id])
    @character = Character.new(book: @book)
    @characters = policy_scope(Character).where(book: @book)

    @chapters = @book.chapters
    @places = @book.places
  end

  def destroy
    book = Book.find(params[:book_id])
    @character = Character.find(params[:id])
    authorize @character

    @character.destroy

    redirect_to book_characters_path(book)
  end

  private

  def character_params
    params.require(:character).permit(:first_name, :last_name)
  end
end
