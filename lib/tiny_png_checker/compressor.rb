require 'tinify'
require 'figaro'
require 'tiny_png_checker/utils/tiny_png'
require 'tiny_png_checker/utils/image_files_retriever'

module TinyPngChecker
  class Compressor

    def initialize
      @errors = []
      @processed = []
    end

    def compress_pngs_on_folders(folders = [])
      begin
        Tinify.key = Figaro.env.tinify_api_key
        Tinify.validate!
      rescue Tinify::Error => e
        abort("Error: Tinify invalid api key #{e}")
      end

      @errors.clear
      @processed.clear

      png_files = Utils::ImageFilesRetriever.get_png_files_from_folders(folders)

      not_processed_files = Utils::TinyPng.not_processed_files(png_files)

      not_processed_files.each { |not_processed_file| process_file(not_processed_file) }

      $stdout.puts("Compressed files:")
      $stdout.puts(@processed)

      if @errors.any?
        $stderr.puts(@errors)
        abort
      end
    end

    def process_file(file)
      begin
        Tinify.from_file(file).to_file(file)
        Utils::TinyPng.mark_files(file)
        @processed << file
      rescue Tinify::AccountError => e
        @errors << "The error message is: #{e.message} with file #{file}, monthly conversion limit #{Tinify.compression_count}"
          # Verify your API key and account limit.
      rescue Tinify::ClientError => e
        @errors << "Check your source image and request options, the error message is: #{e.message} with file #{file}"
          # Check your source image and request options.
      rescue Tinify::ServerError => e
        @errors << "Temporary issue with the Tinify API, the error message is: #{e.message} with file #{file}"
          # Temporary issue with the Tinify API.
      rescue Tinify::ConnectionError => e
        @errors << "A network connection error occurred, the error message is: #{e.message} with file #{file}"
          # A network connection error occurred.
      rescue => e
        @errors << "An error occurred, the error message is: #{e.message} with file #{file}"
        # Something else went wrong, unrelated to the Tinify API.
      end
    end

  end
end