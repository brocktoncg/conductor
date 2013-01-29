module Conductor
  module Generators
    class InstallGenerator < Rails::Generators::Base

    	def setup_gemboree
    	   generate "gemboree:install"
    	end

        def mount_engine
            route "mount Conductor::Engine => '/conductor'"
        end

    	def copy_migrations
    	   generate "conductor:migration"
    	end

    end
  end
end
