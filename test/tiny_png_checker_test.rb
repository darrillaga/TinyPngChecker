require 'test_helper'

class TinyPngCheckerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TinyPngChecker::VERSION
  end
end
