class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(:page => params[:page], :per_page => 5)
        
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
      @article.user = current_user #use current_user method instead of hard coding
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
        render :edit, status: :unprocessable_entity
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

    def require_same_user
      if current_user != @article.user
        flash[:alert] = "You can only edit or delete your own articles"
        redirect_to @article
      end
    end



end