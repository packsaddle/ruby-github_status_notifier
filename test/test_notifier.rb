require_relative 'helper'
module GithubStatusNotifier
  class TestNotifier < Test::Unit::TestCase
    def setup
      @notifier = Notifier.new
    end

    sub_test_case '#decide_state' do
      test 'not state nor exit-status' do
        assert_raise(Error) do
          @notifier.decide_state(nil, nil)
        end
      end
    end
  end
end
