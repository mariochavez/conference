# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'rubygems'
require 'motion-cocoapods'
require 'motion_support/all'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'conference'

  app.frameworks += %w(CoreData)

  app.files.unshift Dir.glob(File.join(app.project_dir, 'app/lib/**/*.rb'))

  app.pods do
    pod 'MagicalRecord'
  end
end
