puts "** loading config/site.rb"

require 'compass'

configuration.preview_server_port = 3000
configuration.preview_server_host = '0.0.0.0'
configuration.use_extensions_for_page_links = true
configuration.sass_options = Compass.sass_engine_options

configuration.haml_options = {
  :attr_wrapper => '"'
}
