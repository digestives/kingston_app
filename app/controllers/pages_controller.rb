class PagesController < ApplicationController

  def index
  	@title = "Index"
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end

  def terms
  	@title = "Terms"
  end

  def help
  	@title = "Help"
  end

end

