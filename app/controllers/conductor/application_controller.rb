module Conductor
  class ApplicationController < ActionController::Base
  	helper Conductor::FormatHelper
  	helper Conductor::TreeHelper
  	helper SortableHelper
  	helper FormHelper
  end
end
