module Conductor
  module TreeHelper
    
    def nested_li(objects, &block)
      objects = objects.order(:lft) if objects.is_a? Class
      return '' if objects.size == 0
      output = "<ol class=\"sortable\"><li id=\"list_1\" class=\"#{get_class(objects.first)}\">"
      path = [nil]
      objects.each_with_index do |o, i|
        if o.parent_id != path.last
          if path.include?(o.parent_id)
            while path.last != o.parent_id
              path.pop
              output << '</li></ol>'
            end
            output << "</li><li id=\"list_#{o.id}\" class=\"#{get_class(o)}\">"
          else
            path << o.parent_id
            output << "<ol><li id=\"list_#{o.id}\" class=\"#{get_class(o)}\">"
          end
        elsif i != 0
          output << "</li><li id=\"list_#{o.id}\" class=\"#{get_class(o)}\">"
        end
        output << '<div class="item">'
        output << '<span class="disclose"><span></span></span>'
        output << capture(o, path.size - 1, &block)
        output << '</div>'
      end
      output << '</li></ol>' * path.length
      output.html_safe
    end

    def get_class(o)
      if o.children.any?
        "mjs-nestedSortable-branch mjs-nestedSortable-collapsed"
      else
        "mjs-nestedSortable-leaf"
      end
    end

  end
end
