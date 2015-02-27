require_relative 'helper'
module GithubStatusNotifier
  class TestGithubStatusNotifier < Test::Unit::TestCase
    test 'version' do
      assert do
        !::GithubStatusNotifier::VERSION.nil?
      end
    end
  end
end

