
module TinyPngChecker
  class BaseProcessor

    attr_accessor :errors, :processed

    def run_process

      self.errors ||= []
      self.processed ||= []

      begin
        yield
      rescue => e
        $stderr.puts("Unrecoverable error #{e}")
      end

      $stdout.puts("Compressed files:")
      $stdout.puts(processed)

      if errors.any?
        $stderr.puts(errors)
        abort
      end
    end
  end
end