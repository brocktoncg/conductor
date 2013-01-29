module Conductor
  class Page < ActiveRecord::Base

    attr_accessible :title, :description, :keywords, :link_url, :deletable, 
      :show_in_menu, :browser_title, :menu_title, :slug, :skip_to_first_child, :draft,
      :page_parts_attributes

    has_many :page_parts

    accepts_nested_attributes_for :page_parts, :allow_destroy => true

    validates :title, :presence => true

    acts_as_nested_set

    before_create :create_slug

    def menu_title
      super && !super.empty? ? super : title
    end

    def browser_title
      super && !super.empty? ? super : title
    end

    def permalink
      link_url && !link_url.empty? ? link_url : "/#{slug}"
    end

    def body
      page_parts.where(title: 'body').first
    end

    def content(title)
      page_parts.where(title: title).first
    end

    def self.save_sort(set)
      prev_item = nil
      set = set.to_hash
      set.each_with_index do |item, index|
      	item = item.second if item.kind_of?(Array)
        dbitem = Page.find(item['id'])
        begin
          prev_item.nil? ? dbitem.move_to_root : dbitem.move_to_right_of(prev_item)
        rescue ActiveRecord::ActiveRecordError
        end
        sort_children(item, dbitem) unless item['children'].nil?
        prev_item = dbitem
      end
    end

    def self.sort_children(element, dbitem)
      prevchild = nil
      element['children'].each do |child|
      	child = child.second if child.kind_of?(Array)
        childitem = Page.find(child['id'])
        begin
          prevchild.nil? ? childitem.move_to_child_of(dbitem) : childitem.move_to_right_of(prevchild)
        rescue ActiveRecord::ActiveRecordError
        end
        sort_children(child, childitem) unless child['children'].nil?
        prevchild = childitem
      end
    end

  private

    def create_slug
      self.slug = self.title.parameterize
    end

  end
end