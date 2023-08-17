class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end
    
    def show   
    end

    def new
      @article = Article.new
    end

    def edit
     # binding.break this is the debugger
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        flash[:notice] = "Your article was successfully created!"
        redirect_to @article
      else   
        render 'new'
      end  
    end

    def update
      if @article.update(article_params)
        flash[:notice] = "Your article was successfully updated"
        redirect_to @article
      else    
        render 'edit'
      end
      
    end

    def destroy
      @article.destroy
      redirect_to articles_path, notice: 'Article was successfully destroyed.'
    end


    private
    
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end


end