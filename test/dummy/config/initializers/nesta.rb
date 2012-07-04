ENV['NESTA_CONTENT'] = File.join(Rails.root, 'content')
ENV['NESTA_TITLE'] = 'Configure your title'
ENV['NESTA_SUBTITLE'] = 'Configure your subtitle'

# ENV['NESTA_AUTHOR__NAME'] = ''
# ENV['NESTA_AUTHOR__URI'] = ''
# ENV['NESTA_AUTHOR__EMAIL'] = ''
#
# ENV['NESTA_GOOGLE_ANALYTICS_CODE'] = 'UA-???'
#
# ENV['NESTA_DISQUS_SHORT_NAME'] = 'theagileplanner'

require 'sass/util'

require 'nesta/env'
Nesta::Env.root = Rails.root

require 'nesta/app'

Rails.application.config.middleware.insert_after(
  Rack::Lock,
  Rack::Static, :urls => ['/attachments'], :root => File.expand_path('content'))

Haml::Template.options[:format] = :xhtml
