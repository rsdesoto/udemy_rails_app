class ArticlesController < ApplicationController
  def show
    set_article
  end

  def index
    @articles = Article.all
  end

  def new
  end

  def edit
    set_article
  end

  def create
    # require the top level key article, then permit the subkeys title and desc
    @article = Article.new(permissions)
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    set_article
    if @article.update(permissions)
      flash[:notice] = "Article was updated successfully."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    set_article
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def permissions
    params.require(:article).permit(:title, :description)
  end
end
