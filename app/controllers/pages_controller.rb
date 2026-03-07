class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout "public"

  def home
  end

  def pricing
  end
end
