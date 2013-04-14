require 'gemboree'
require 'awesome_nested_set'

module Conductor
  class Engine < ::Rails::Engine
    isolate_namespace Conductor
  end
end
