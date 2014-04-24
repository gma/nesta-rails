require 'nesta-rails/action_dispatch_extensions'
require 'nesta-rails/app/helpers/site_helper'
require 'nesta-rails/version'
require 'tilt'

require 'nesta/env'
Nesta::Env.root = Rails.root
require 'nesta/app'

module Nesta
  class Engine < ::Rails::Engine
    initializer 'nesta.configure_rails_initialization' do |app|
      app.middleware.insert_after(
        Rack::Lock,
        Rack::Static,
          :urls => ['/attachments'], :root => File.expand_path('content'))
    end
  end
end
