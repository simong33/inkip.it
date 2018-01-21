class ReactionsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized

  def create
    user = current_user
    @chapter = Chapter.find(params[:chapter])
    ink = Reaction.new(user: user, chapter: @chapter, value: 1)
    ink.save

    respond_to do |format|
      format.html { redirect_to @chapter }
      format.js
    end
  end

  def update

    @chapter = Chapter.find(params[:chapter])

    ink = Reaction.find(params[:id])
    ink.value += 1
    ink.save

    respond_to do |format|
      format.html { redirect_to @chapter }
      format.js
    end
  end
end
