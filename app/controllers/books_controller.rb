class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def index
    @books = current_user.books.order('updated_at DESC')
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters.order('created_at')
    @chapter = Chapter.new
    @characters = @book.characters
    @character = Character.new
    @places = @book.places
    @place = Place.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to book_path(@book), alert: 'Vous avez ajouté un nouveau livre !'
    end
  end

  def statistics
    @book = Book.find(params[:book_id])

    # DWC

    @dwc = @book.daily_word_counts.order('created_at').last(30)
    @dwc_year = @book.daily_word_counts.order('created_at').last(365)
    @dwc_dates = []
    @dwc_values = []
    @dwc_total_values = []

    @dwc.each do |dwc|
      @dwc_dates << dwc.created_at.strftime('%d/%m/%Y')
      @dwc_values << dwc.wordcount
      @dwc_total_values << dwc.total_word_count
    end

    # CAL-HEATMAP

    dwc_map = @dwc_year.map {|dwc| [dwc.created_at.strftime('%Y/%m/%d'), dwc.wordcount]}
    dwc_hash = Hash[dwc_map]
    @dwc_calendar = dwc_hash.to_json

  end

  private

  def book_params
    params.require(:book).permit(:title, :word_goal)
  end

end
