module Conductor
  class PagesController < ApplicationController

    load_and_authorize_resource :except => [:show, :create, :update, :preview]
    authorize_resource :only => [:create, :update, :preview]

    def index
      @pages = Page.order('lft ASC')
      respond_to do |format|
        format.html
        format.json { render json: @pages }
      end
    end

    def show
      if params[:slug]
        @page = Page.find_by_slug(params[:slug])
        if @page.nil? || @page.draft?
          render_404
        elsif @page.link_url && !@page.link_url.empty?
          redirect_to @page.link_url
        end
      elsif params[:id]
        @page = Page.find(params[:id])
      else
        @page = Page.find_by_link_url('/')
      end
    end

    def new
      @page = Page.new
      @page.page_parts.new(title: 'body')
      respond_to do |format|
        format.html
        format.json { render json: @page }
      end
    end

    def edit
    end

    def create
      parent_id = params[:page][:parent_id]
      params[:page].delete('parent_id')
      @page = Page.new(params[:page])
      respond_to do |format|
        if @page.save
          if !parent_id.blank?
            parent = Page.find(parent_id)
            @page.move_to_child_of(parent)
          end
          format.html { redirect_to @page, notice: 'Page was successfully created.' }
          format.json { render json: @page, status: :created, location: @page }
        else
          format.html { render action: "new" }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      parent_id = params[:page][:parent_id]
      params[:page].delete('parent_id')

      if params[:commit] == "Preview"
        @page = Page.new(params[:page])
        render 'show'
        return true
      end

      @page = Page.find(params[:id])
      respond_to do |format|
        if @page.update_attributes(params[:page])
          if parent_id.blank?
            @page.move_to_root
          else
            parent = Page.find(parent_id)
            @page.move_to_child_of(parent)
          end
          format.html { redirect_to @page, notice: 'Page was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @page.destroy
      respond_to do |format|
        format.html { redirect_to pages_url }
        format.json { head :no_content }
      end
    end
    
    def new_child
      @page = Page.new
      @page.parent_id = params[:page_id]
      render 'new'
    end

    def savesort
      Page.save_sort(params[:set])
      head :no_content
    end

  end
end
