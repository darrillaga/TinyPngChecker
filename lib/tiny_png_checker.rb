require 'tiny_png_checker/version'
require 'tiny_png_checker/checker'
require 'tiny_png_checker/compressor'
require 'tiny_png_checker/marker'

require 'figaro'
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

module TinyPngChecker

end
