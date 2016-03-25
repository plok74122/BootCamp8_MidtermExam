class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :article_params , :only =>[:create , :update]
  before_action :article_id_params , :only =>[:edit ,:update ,:show ,:destroy]
  before_action :set_article, :only => [:show, :edit, :update ,:destroy]

  def index
    @articles =Article.all
  end

  def new
    @articles = Article.new
    @all_article_type_collection = ArticleType.all
  end

  def my_articles
    @articles = Article.where('user_id' =>current_user.id).page(params[:page]).per(5)
  end

  def create
    new_article = Article.new(article_params)
    new_article.user_id = current_user.id
    flash[:notice] = new_article.save
    redirect_to articles_path
  end

  def show
    @comment = Comment.new
    @comment_list = @article.comments.order('updated_at DESC')
  end

  def destroy
    if @article.user_id == current_user.id
      @article.delete
      flash[:notice] ='已刪除留言'
    else
      flash[:notice] ='不能刪除他人的留言'
    end
    redirect_to :back
  end

  def edit
    @all_article_type_collection = ArticleType.all

    if(@article.user_id != current_user.id)
      flash[:notice] = "can't access"
      redirect_to :back
    end
  end
  def update
    if(@article.user_id != current_user.id)
      flash[:notice] = "can't Update This Article"
      redirect_to articles_path
    else
      @article.update(article_params)
      redirect_to articles_path
    end
  end

  private

  def set_article
    @article = Article.find(@article_id['id'])
  end

  def article_params
    params.require(:article).permit(:title, :content, :article_type_id )
  end

  def article_id_params
    @article_id = params.permit(:id)
  end
end
