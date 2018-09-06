require "chunky_png"

module TinyPngChecker
  class Checker

    def check_tiny_png_on_folders(folders)
      png_files = folders.flat_map { |base_dir| Dir.glob("#{File.expand_path(base_dir)}/**/*.png")}

      not_processed_files = png_files.select do |file|
        image = ChunkyPNG::Image.from_file(file)
        image.metadata['TinyPNGProcessedFlag'].nil?
      end

      if not_processed_files.any?
        puts "Files not processed by TinyPNG:"
        puts not_processed_files

        exit(1)
      end
    end

  end
end