require 'logger'
require 'saddler/reporter/github'
require 'github_status_notifier/version'
require 'github_status_notifier/notifier'

module GithubStatusNotifier
  class Error < StandardError; end

  def self.default_logger
    logger = Logger.new(STDERR)
    logger.progname = 'GithubStatusNotifier'
    logger.level = Logger::WARN
    logger
  end

  def self.logger
    return @logger if @logger
    @logger = default_logger
  end

  class << self
    attr_writer :logger
  end
end
