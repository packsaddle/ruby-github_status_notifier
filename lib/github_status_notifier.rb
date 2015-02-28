require 'github_status_notifier/version'
require 'logger'

module GithubStatusNotifier
  def self.logger
    return @logger if @logger

    @logger = Logger.new(STDERR)
    @logger.progname = 'GithubStatusNotifier'
    @logger.level = Logger::WARN
    @logger
  end

  def self.logger=(logger)
    @logger = logger
  end
end
