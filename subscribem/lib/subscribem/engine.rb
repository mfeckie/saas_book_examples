module Subscribem
  class Engine < ::Rails::Engine
    isolate_namespace Subscribem

    config.to_prepare do
      root = Subscribem::Engine.root
      extenders_path = root + "app/extenders/**/*.rb"
      Dir.glob(extenders_path) do |file|
        Rails.configuration.cache_classes ? require(file) : load(file)
      end
    end
  end
end

