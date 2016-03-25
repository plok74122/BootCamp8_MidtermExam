class InformationController < ApplicationController
  def index
    @articles =Article.page(params[:page]).per(5)
  end
end
