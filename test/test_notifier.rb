require_relative 'helper'
module GithubStatusNotifier
  class TestNotifier < Test::Unit::TestCase
    def setup
      @notifier = Notifier.new
    end

    sub_test_case '#decide_state' do
      success_exit_status = 0
      failure_exit_status = 1

      test 'not state nor exit-status' do
        assert_raise(ArgumentError) do
          @notifier.decide_state(nil, nil)
        end
      end

      test 'invalid state' do
        assert_raise(InvalidStateError) do
          @notifier.decide_state('invalid', nil)
        end
      end

      test 'valid state' do
        assert do
          @notifier.decide_state('success', nil) == Notifier::SUCCESS
        end
      end
      test 'state case insensitive' do
        assert do
          @notifier.decide_state('fAiluRe', nil) == Notifier::FAILURE
        end
      end
      test 'exit status success' do
        assert do
          @notifier.decide_state(nil, success_exit_status) == Notifier::SUCCESS
        end
      end
      test 'exit status failure' do
        assert do
          @notifier.decide_state(nil, failure_exit_status) == Notifier::FAILURE
        end
      end
      test 'state over exit status' do
        assert do
          @notifier.decide_state('error', success_exit_status) == Notifier::ERROR
        end
      end
    end
    sub_test_case '#decide_context' do
      test 'no context' do
        assert do
          @notifier.decide_context(nil) == Notifier::CONTEXT
        end
      end
      test 'with context' do
        your_context = 'your_context'
        assert do
          @notifier.decide_context(your_context) == your_context
        end
      end
    end
  end
end
