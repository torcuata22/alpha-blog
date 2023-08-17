class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
    
    def show   
      @article = Article.find(params[:id])  
    end

    def new
      @article = Article.new
    end

    def edit
     # binding.break this is the debugger
      @article = Article.find(params[:id])
    end

    def create
      @article = Article.new(params.require(:article).permit(:title, :description))
      if @article.save
        flash[:notice] = "Your article was successfully created!"
        redirect_to @article
      else   
        render 'new'
      end  
    end

    def update
      @article = Article.find(params[:id])
      if @article.update(params.require(:article).permit(:title, :description))
        flash[:notice] = "Your article was successfully updated"
        redirect_to @article
      else    
        render 'edit'
      end
      
    end

end