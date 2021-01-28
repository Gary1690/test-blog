class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,:edit,:update,:destroy]
  before_action :require_user, except: [:index,:show]
  before_action :require_same_user, only: [:update,:edit,:destroy]

  def show
    
  end

  def index 
    @articles = Article.paginate(page:params[:page], per_page:5)
  end

  def new 
    @article = Article.new 
  end

  def create 
    @article = Article.new(articles_params)
    @article.user = current_user
    if (@article.save)
      flash[:notice] = "Article was created sucessfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit 
    
  end

  def update 
    
    if (@article.update(articles_params))
      flash[:notice] = "Article was updated sucessfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy 
    
    @article.destroy
    redirect_to articles_path
  end

  private
  def articles_params 
    params.require(:article).permit(:title,:description)
  end

  def  set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit your own articles"
      redirect_to articles_path
    end
  end 
end