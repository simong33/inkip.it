class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def index
    @books = policy_scope(Book).order('updated_at DESC')
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
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

  def update
    @book = Book.find(params[:id])
    authorize @book

    if @book.update(book_params)
      redirect_to book_settings_path(@book), alert: "Vous avez modifié votre livre !"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    authorize @book

    redirect_to root_path, alert: "Vous venez d'effacer votre livre :( !"
  end

  def download
    @book = Book.find(params[:book_id])
    chapters = @book.chapters.order('created_at')

    @book_content = []

    chapters.each do |chapter|
      @book_content << [chapter.title, chapter.content]
    end

    respond_to do |format|
      format.docx do
        render docx: 'download_book', filename: @book.title + ".docx"
      end
    end
  end

  def statistics
    @book = Book.find(params[:book_id])
    authorize @book

    chapters = @book.chapters

    # DWC

    dwc = @book.daily_word_counts.order('created_at').last(30)
    dwc_year = @book.daily_word_counts.order('created_at').last(365)
    dwc_all = @book.daily_word_counts

    dwc_dates = []
    dwc_values = []
    dwc_total_values = []

    dwc.each do |dwc|
      dwc_dates << dwc.created_at.strftime('%d/%m/%Y')
      dwc_values << dwc.wordcount
      dwc_total_values << dwc.total_word_count
    end

    gon.dwc_dates = dwc_dates.as_json
    gon.dwc_values = dwc_values.as_json
    gon.dwc_total_values = dwc_total_values.as_json

    # WORDCOUNT GOAL

    gon.wordcount = @book.wordcount

    if @book.word_goal
      gon.words_left = @book.word_goal - @book.wordcount
    end

    # CAL-HEATMAP

    dwc_map = dwc_year.map {|dwc| [dwc.created_at.to_datetime.strftime('%s'), dwc.wordcount]}
    dwc_hash = Hash[dwc_map]
    gon.dwc_calendar = dwc_hash

    # WORDS PER SESSION

    unless chapters.empty? || dwc_all.empty?
      @words_per_session = @book.wordcount / dwc_all.count
    else
      @words_per_session = 0
    end

    # WORDS PER CHAPTER

    unless chapters.empty?
      @words_per_chapter = (@book.wordcount / chapters.count)
    else
      @words_per_chapter = 0
    end
  end

  def settings
    @book = Book.find(params[:book_id])
    authorize @book

  end

  private

  def book_params
    params.require(:book).permit(:title, :word_goal)
  end

end
