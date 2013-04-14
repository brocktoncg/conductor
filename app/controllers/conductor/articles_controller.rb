module Conductor
  class ArticlesController < ApplicationController

    helper_method :sort_column, :sort_direction

    def index
      @articles = Conductor::Article.order("#{sort_column} #{sort_direction}").page(params[:page])
      respond_to do |format|
        format.html
        format.json { render json: @articles }
      end
    end

    def show
      if params[:slug]
        @article = Conductor::Article.find_by_slug(params[:slug])
        render_404 if @article.nil? || @article.draft?
      elsif params[:id]
        @article = Conductor::Article.find(params[:id])
      end
      @comment = @article.comments.new
      respond_to do |format|
        format.html
        format.json { render json: @article }
      end
    end

    def new
      @article = Conductor::Article.new
      respond_to do |format|
        format.html
        format.json { render json: @article }
      end
    end

    def edit
    end

    def create
      @article = current_user.articles.new(params[:article])
      respond_to do |format|
        if @article.save
          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render json: @article, status: :created, location: @article }
        else
          format.html { render action: "new" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @article.update_attributes(params[:article])
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url }
        format.json { head :no_content }
      end
    end

    def home
      @articles = Conductor::Article.all
      render 'landing'
    end

    def tag
      @tag = @article.tag(params[:tag_name])
      redirect_to edit_article_path(@article)
    end

    def untag
      @article.untag(params[:tag_id])
      redirect_to edit_article_path(@article)
    end

  private

    def sort_column
      Conductor::Article.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

  end
end