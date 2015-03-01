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

    desc 'notify', 'Notify current state to GitHub status'
    option :exit_status, type: :numeric
    option :keep_exit_status, type: :boolean, default: false
    option :debug, type: :boolean, default: false
    option :verbose, type: :boolean, default: false
    option :state, type: :string, enum: Notifier::ALLOWED_STATUS
    option :target_url, type: :string
    option :description, type: :string
    option :context, type: :string, default: Notifier::CONTEXT
    def notify
      if options[:debug]
        logger.level = Logger::DEBUG
      elsif options[:verbose]
        logger.level = Logger::INFO
      end
      logger.debug(options.inspect)
      if options[:keep_exit_status] && !options[:exit_status]
        fail ArgumentError, 'keep-exit-status requires exit-status'
      end

      params = {
        state: options[:state],
        exit_status: options[:exit_status],
        target_url: options[:target_url],
        description: options[:description],
        context: options[:context]
      }

      Notifier.new.notify(params)

      if options[:keep_exit_status]
        exit options[:exit_status]
      end
    rescue StandardError => e
      logger.error 'options:'
      logger.error options
      raise e
    end

    no_commands do
      def logger
        ::GithubStatusNotifier.logger
      end
    end
  end
end
