require 'tiny_png_checker/base_processor'
require 'tiny_png_checker/utils/tiny_png'
require 'tiny_png_checker/utils/image_files_retriever'

module TinyPngChecker
  class UnmarkedFilesProcessor < BaseProcessor

    def process_pngs_on_folders(folders = [])
      run_process do
        setup

        png_files = Utils::ImageFilesRetriever.get_png_files_from_folders(folders)

        not_processed_files = Utils::TinyPng.not_processed_files(png_files)

        not_processed_files.each { |not_processed_file| process_file(not_processed_file) }
      end
    end

    def process_file(_)
    end

    def setup
    end

  end
end