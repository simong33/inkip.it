class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :privacy_policy, :tos, :cgu, :mentions_legales]

  def rankings

    case params["filter"]

    when "words_max"
      @authors = User.best_authors_max
      @filter = "words_max"

      respond_to do |format|
          format.js
      end

    when "words_mean"
      @authors = User.best_authors_mean
      @filter = "words_mean"

      respond_to do |format|
          format.js
      end

    when "streaks_max"
      @authors = User.most_consistent_authors
      @filter = "streaks_max"
      @streaks = "streaks_max"

      respond_to do |format|
          format.js
      end

    else

      @authors = User.best_authors_max

    end
  end

end
