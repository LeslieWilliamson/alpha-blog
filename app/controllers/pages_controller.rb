class PagesController < ApplicationController
  def home
    # The redirect below is an alternative solution to the code in views/layouts/_navigation.html.erb
    # redirect_to user_path(current_user) if logged_in?
  end

  def about
  end
end
