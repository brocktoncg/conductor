module Conductor
  class Article < ActiveRecord::Base

    attr_accessible :body, :draft, :expire_at, :featured, :post_at, :title, :user_id

    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :article_tags, :dependent => :destroy
    has_many :tags, :through => :article_tags

    before_create :create_slug

    default_scope :order => 'post_at DESC'

    validates_presence_of :title, :body

    def tag(name)
      tag = Conductor::Tag.find_by_name(name)
      tag ||= Conductor::Tag.create(name: name)
      tags << tag if !tags.exists?(tag)
      tag
    end
    
    def untag(id)
      tag = Conductor::Tag.find(id)
      tags.delete(tag)
      if tag.articles.empty?
        tag.delete
      end
    end

    def permalink
      post_at? ? "/blog/#{post_at.year}/#{post_at.month}/#{slug}" : "blog/#{id}"
    end

  private

    def create_slug
      self.slug = self.title.parameterize
    end

  end
end
