require 'chunky_png'

module Utils
  module TinyPng

    PNG_PROCESSED_FLAG = 'TinyPNGProcessedFlag'
    PNG_PROCESSED_FLAG_VALUE = 'P'

    def self.not_processed_files(png_files = [])

      png_files.select do |file|
        image = ChunkyPNG::Image.from_file(file)
        image.metadata[PNG_PROCESSED_FLAG].nil?
      end

    end

    def self.mark_files(*png_files)

      png_files.compact!

      png_files.each do |file|
        image = ChunkyPNG::Image.from_file(file)
        image.metadata[PNG_PROCESSED_FLAG] = PNG_PROCESSED_FLAG_VALUE
        image.save(file)
      end

    end

  end
end