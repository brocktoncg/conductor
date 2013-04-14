module Conductor
	class Tag < ActiveRecord::Base

	  attr_accessible :name

	  has_many :article_tags, :dependent => :destroy
	  has_many :articles, :through => :article_tags

	  validates :name,
	    :presence => true,
	    :uniqueness => true

	end
end
