class RecommendationController < ApplicationController
  def index
    @list = current_user.lists.build
  end
end
