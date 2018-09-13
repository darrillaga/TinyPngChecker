
module TinyPngChecker
  class BaseProcessor

    attr_accessor :errors, :processed

    def run_process

      errors.clear
      processed.clear

      begin
        yield
      rescue Exception => e
        $stderr.puts("Unrecoverable error")
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