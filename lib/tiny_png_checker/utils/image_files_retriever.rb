module Utils
  module ImageFilesRetriever

    def self.get_png_files_from_folders(folders)
      folders.flat_map { |base_dir| Dir.glob("#{File.expand_path(base_dir)}/**/*.png") } || []
    end

  end
end