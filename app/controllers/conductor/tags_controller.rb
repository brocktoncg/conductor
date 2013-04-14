module Conductor
  class TagsController < ApplicationController

    helper_method :sort_column, :sort_direction

    def index
      @tags = Conductor::Tag.order("#{sort_column} #{sort_direction}").page(params[:page])
      respond_to do |format|
        format.html
        format.json { render json: @tags }
      end
    end

    def new
      @tag = Conductor::Tag.new
      respond_to do |format|
        format.html
        format.json { render json: @tag }
      end
    end

    def edit
    end

    def create
      @tag = Conductor::Tag.new(params[:tag])
      respond_to do |format|
        if @tag.save
          format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
          format.json { render json: @tag, status: :created, location: @tag }
        else
          format.html { render action: "new" }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @tag.update_attributes(params[:tag])
          format.html { redirect_to tags_path, notice: 'Tag was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @tag.destroy
      respond_to do |format|
        format.html { redirect_to tags_url }
        format.json { head :no_content }
      end
    end
    
  private

    def sort_column
      Conductor::Tag.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

  end
end