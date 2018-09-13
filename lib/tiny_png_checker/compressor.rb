require 'tinify'
require 'figaro'
require 'tiny_png_checker/utils/tiny_png'
require 'tiny_png_checker/unmarked_files_processor'

module TinyPngChecker
  class Compressor < UnmarkedFilesProcessor

    def setup
      begin
        Tinify.key = Figaro.env.tinify_api_key
        Tinify.validate!
      rescue Tinify::Error => e
        abort("Error: Tinify invalid api key #{e}")
      end
    end

    def process_file(file)
      begin
        Tinify.from_file(file).to_file(file)
        Utils::TinyPng.mark_files(file)
        processed << file
      rescue Tinify::AccountError => e
        errors << "The error message is: #{e.message} with file #{file}, monthly conversion limit #{Tinify.compression_count}"
        raise e
          # Verify your API key and account limit.
      rescue Tinify::ClientError => e
        errors << "Check your source image and request options, the error message is: #{e.message} with file #{file}"
          # Check your source image and request options.
      rescue Tinify::ServerError => e
        errors << "Temporary issue with the Tinify API, the error message is: #{e.message} with file #{file}"
          # Temporary issue with the Tinify API.
      rescue Tinify::ConnectionError => e
        errors << "A network connection error occurred, the error message is: #{e.message} with file #{file}"
          # A network connection error occurred.
      rescue => e
        errors << "An error occurred, the error message is: #{e.message} with file #{file}"
        # Something else went wrong, unrelated to the Tinify API.
      end
    end

  end
end