class ReactionsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized

  def create
    @chapter = Chapter.find(params[:chapter])

    if current_user.reacted_at?(@chapter)
      reaction = Reaction.find_by("user_id = ? AND chapter_id = ?", current_user.id, @chapter.id)
      reaction.inks += 1
      reaction.save
    else
      reaction = Reaction.new(user: current_user, chapter_id: @chapter.id, inks: 1)
      reaction.chapter = @chapter
      reaction.save
    end

      @total_inks = @chapter.inks

      @user_inks = "+" + @chapter.inks_by(current_user).to_s
      gon.user_inks = @user_inks


    respond_to do |format|
      format.html { redirect_to @chapter }
      format.js
    end
  end

  def update

    @chapter = Chapter.find(params[:chapter])

    reaction = Reaction.find(params[:id])
    reaction.inks += 1
    reaction.save

    @total_inks = @chapter.inks

    @user_inks = "+" + @chapter.inks_by(current_user).to_s

    respond_to do |format|
      format.html { redirect_to @chapter }
      format.js
    end
  end
end
