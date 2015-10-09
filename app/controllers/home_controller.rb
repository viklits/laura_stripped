class HomeController < ApplicationController

  # @description Current User's dashboard
  def dashboard
    respond_with_interaction Dashboard::Dashboard, params
  end
end
