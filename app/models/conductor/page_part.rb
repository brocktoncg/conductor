module Conductor
	class PagePart < ActiveRecord::Base

	  attr_accessible :body, :page_id, :position, :title

	  belongs_to :page

	end
end
