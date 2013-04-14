module Conductor
  module FormatHelper

  	def short_date(date)
      date.nil? ? "Never" : date.strftime('%b %d')
    end
    
    def med_date(date)
      date.nil? ? "Never" : date.strftime('%b %d, %Y')
    end
    
    def long_date(date)
      date.nil? ? "Never" : date.strftime('%-m/%-d/%Y  %l:%M %p')
    end

    def input_date(date)
    	date.nil? ? "" : date.strftime('%Y-%m-%d %I:%M %P')
    end

  end
end
