# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion_support/all'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'conference'

  app.frameworks += %w(CoreData CoreLocation MapKit)

  app.files.unshift *Dir.glob(File.join(app.project_dir, 'app/lib/**/*.rb'))

  app.pods do
    pod 'MagicalRecord', '~> 2.0.0'
  end
end
