class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :privacy_policy, :tos]

  def landing
  end

  def privacy_policy
  end

  def tos
  end
end
