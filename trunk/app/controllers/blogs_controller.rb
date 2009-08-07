class BlogsController < ApplicationController

  def show
    @pages = Page.bloggings.recent
  end
end
