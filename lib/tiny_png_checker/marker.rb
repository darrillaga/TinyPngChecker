require 'tiny_png_checker/utils/tiny_png'
require 'tiny_png_checker/unmarked_files_processor'

module TinyPngChecker
  class Marker < UnmarkedFilesProcessor

    def process_file(file)
      begin
        Utils::TinyPng.mark_files(file)
        processed << file
      rescue => e
        errors << "An error occurred, the error message is: #{e.message} with file #{file}"
      end
    end

  end
end