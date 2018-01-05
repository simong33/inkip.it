class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :rankings, :privacy_policy, :tos]

  def landing
  end

  def rankings
    @best_authors_max = User.best_authors_max
    @best_authors_mean = User.best_authors_mean
  end

  def privacy_policy
  end

  def tos
  end
end
