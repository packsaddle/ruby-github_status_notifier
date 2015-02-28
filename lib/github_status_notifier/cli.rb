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
    option :state, type: :string
    option :target_url, type: :string
    option :description, type: :string
    option :context, type: :string
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

      params = {
        state: options[:state],
        exit_status: options[:exit_status],
        target_url: options[:target_url],
        description: options[:description],
        context: options[:context]
      }

      notifier_notify(params)

      if options[:keep_exit_status]
        exit options[:exit_status]
      end
    end

    no_commands do
      def logger
        ::GithubStatusNotifier.logger
      end

      PENDING = 'pending'
      SUCCESS = 'success'
      ERROR = 'error'
      FAILURE = 'failure'
      ALLOWED_STATUS = [PENDING, SUCCESS, ERROR, FAILURE]
      def notifier_notify(params)
        state = determine_state(params[:state], params[:exit_status])
        pass_params = {
          target_url: params[:target_url],
          description: params[:description],
          context: params[:context]
        }
        deliver_notification(pass_params.merge(state: state))
      rescue StandardError => e
        logger.error e.message
        logger.error e.backtrace
        deliver_notification(pass_params.merge(state: ERROR))
      end

      def deliver_notification(params)
      end

      def determine_state(state, exit_status)
        if state
          return state.downcase if ALLOWED_STATUS.include?(state.downcase)
          logger.error "state: #{state} is invalid. allowed #{ALLOWED_STATUS}"
          fail ::GithubStatusNotifier::Error
        elsif exit_status
          return SUCCESS if exit_status.to_i == 0
          return FAILURE
        else
          logger.error 'require state or exit_state'
          fail ::GithubStatusNotifier::Error
        end
      end
    end
  end
end
