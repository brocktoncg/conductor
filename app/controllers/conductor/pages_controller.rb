module Conductor
  class PagesController < ApplicationController

    def index
      @pages = Conductor::Page.order('lft ASC')
    end

    def show
      if params[:slug]
        @page = Conductor::Page.find_by_slug(params[:slug])
        if @page.nil? || @page.draft?
          render_404
        elsif @page.link_url && !@page.link_url.empty?
          redirect_to @page.link_url
        end
      elsif params[:id]
        @page = Conductor::Page.find(params[:id])
      else
        @page = Conductor::Page.find_by_link_url('/')
      end
    end

    def new
      @page = Conductor::Page.new
      @page.page_parts.new(title: 'body')
    end

    def edit
      @page = Conductor::Page.find(params[:id])
    end

    def create
      parent_id = params[:page][:parent_id]
      params[:page].delete('parent_id')
      @page = Conductor::Page.new(params[:page])
      if @page.save
        if !parent_id.blank?
          parent = Conductor::Page.find(parent_id)
          @page.move_to_child_of(parent)
        end
        redirect_to @page, notice: 'Page was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      parent_id = params[:page][:parent_id]
      params[:page].delete('parent_id')
      if params[:commit] == "Preview"
        @page = Conductor::Page.new(params[:page])
        render 'show'
        return true
      end
      @page = Conductor::Page.find(params[:id])
      if @page.update_attributes(params[:page])
        if parent_id.blank?
          @page.move_to_root
        else
          parent = Conductor::Page.find(parent_id)
          @page.move_to_child_of(parent)
        end
        redirect_to @page, notice: 'Page was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_url
    end
    
    def new_child
      @page = Conductor::Page.new
      @page.parent_id = params[:page_id]
      render 'new'
    end

    def savesort
      Conductor::Page.save_sort(params[:set])
      head :no_content
    end

  end
end
