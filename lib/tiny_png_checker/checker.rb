require 'tiny_png_checker/utils/image_files_retriever'
require 'tiny_png_checker/utils/tiny_png'

module TinyPngChecker
  class Checker

    def check_tiny_png_on_folders(folders = [])
      png_files = Utils::ImageFilesRetriever.get_png_files_from_folders(folders)

      not_processed_files = Utils::TinyPng.not_processed_files(png_files)

      if not_processed_files.any?
        $stderr.puts("Files not processed by TinyPNG:")
        $stderr.puts(not_processed_files)
        abort
      else
        $stdout.puts("No files to process")
      end
    end

  end
end