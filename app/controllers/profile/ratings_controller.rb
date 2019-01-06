class Profile::RatingsController < ApplicationController

  def new
    @rating = Rating.new
    @form_path = [:profile, @rating]
  end

end
