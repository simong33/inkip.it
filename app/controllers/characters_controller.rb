class CharactersController < ApplicationController
  def create
    @character = Character.new(character_params)
    @character.book = Book.find(params[:book_id])
    authorize @character

    if @character.save
      redirect_to book_character_path(@character.book, @character), alert: "Vous avez ajouté un nouveau personnage !"
    end
  end

  def show
    @character = Character.find(params[:id])
    @book = @character.book
    authorize @character
  end

  def index
    @book = Book.find(params[:book_id])
    @character = Character.new(book: @book)
    @characters = policy_scope(Character).where(book: @book).order('created_at')

    @chapters = @book.chapters
    @places = @book.places
  end

  def update
    @character = Character.find(params[:id])
    authorize @character

    if @character.update(character_all_params)
      redirect_to book_character_path(@character.book, @character), alert: "Votre fiche personnage a bien été sauvegardée !"
    end
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

  def character_all_params
    params.require(:character).permit!
  end
end
