class MainController < ApplicationController
  def index
  	@posts = Post.order('id desc').limit(5)
  end

  def about
  end

  def contact
  end
  
end
