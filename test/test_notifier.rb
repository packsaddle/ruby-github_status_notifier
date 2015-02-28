require_relative 'helper'
module GithubStatusNotifier
  class TestNotifier < Test::Unit::TestCase
    test 'version' do
      assert do
        !::GithubStatusNotifier::VERSION.nil?
      end
    end
  end
end
