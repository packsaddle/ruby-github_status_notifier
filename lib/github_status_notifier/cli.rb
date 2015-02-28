require 'thor'

module GithubStatusNotifier
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Show the GithubStatusNotifier version'
    map %w(-v --version) => :version

    def version
      puts "GithubStatusNotifier version #{::GithubStatusNotifier::VERSION}"
    end

    desc 'notify', 'Notify current status to GitHub status'
    option :exit_status, type: :numeric
    option :keep_exit_status, type: :boolean, default: false
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    def notify
      if options[:debug]
        logger.level = Logger::DEBUG
      elsif options[:verbose]
        logger.level = Logger::INFO
      end
      logger.debug(options.inspect)
      if options[:keep_exit_status] && !options[:exit_status]
        logger.error 'keep-exit-status requires exit-status'
        abort
      end

      if options[:keep_exit_status]
        exit options[:exit_status]
      end
    end

    no_commands do
      def logger
        ::GithubStatusNotifier.logger
      end
    end
  end
end
