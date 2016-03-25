class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :article_params , :only =>[:create , :update]

  def index
    @articles =Article.all
  end

  def new
    @articles = Article.new
    @all_article_type_collection = ArticleType.all
  end
  def create
    new_article = Article.new(article_params)
    new_article.user_id = current_user.id
    flash[:notice] = new_article.save
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(@article_id['id'])
  end

  def article_params
    params.require(:article).permit(:title, :content, :article_type_id )
  end

end
