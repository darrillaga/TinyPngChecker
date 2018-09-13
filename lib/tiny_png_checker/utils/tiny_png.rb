require 'chunky_png'
require 'parallel'

module Utils
  module TinyPng

    PNG_PROCESSED_FLAG = 'TinyPNGProcessedFlag'
    PNG_PROCESSED_FLAG_VALUE = 'P'

    def self.not_processed_files(png_files = [])

      Parallel.map(png_files) do |file|
        begin
          # image = ChunkyPNG::Image.from_file(file)
          # image.metadata[PNG_PROCESSED_FLAG].nil? ? file : nil

          if !look_for_metadata_flag_from_io(File.open(file)) { |chunk| is_tinypng_metadata_chunk(chunk) }
            file
          end
        rescue => e
          $stdout.puts("WARNING: File is not a PNG: #{file}, error: #{e}")
          nil
        end
      end.compact

    end

    def self.is_tinypng_metadata_chunk(chunk)
      if chunk.respond_to?(:keyword) && chunk.respond_to?(:value)
        chunk.keyword == PNG_PROCESSED_FLAG && chunk.value.nil?
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

    def self.look_for_metadata_flag_from_io(io)
      ChunkyPNG::Datastream.verify_signature!(io)

      end_chunk = false
      found = false

      while !end_chunk && !found
        chunk = ChunkyPNG::Chunk.read(io)
        case chunk
        when ChunkyPNG::Chunk::End
          end_chunk = true
        else
          found = !yield(chunk).nil?
        end
      end

      found
    end

  end
end