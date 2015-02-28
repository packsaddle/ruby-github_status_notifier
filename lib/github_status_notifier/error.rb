module GithubStatusNotifier
  class GithubStatusNotifierError < StandardError; end
  class ArgumentError < GithubStatusNotifierError; end
  class InvalidStateError < GithubStatusNotifierError; end
end
