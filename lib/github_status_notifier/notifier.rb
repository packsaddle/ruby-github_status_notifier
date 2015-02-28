module GithubStatusNotifier
  class Notifier
    PENDING = 'pending'
    SUCCESS = 'success'
    ERROR = 'error'
    FAILURE = 'failure'
    ALLOWED_STATUS = [PENDING, SUCCESS, ERROR, FAILURE]

    def notify(params)
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
      repo_path = '.'
      repo = Repository.new(repo_path)
      client = Client.new(repo)
      client.create_status(params)
    end

    def determine_state(state, exit_status)
      if state
        return state.downcase if ALLOWED_STATUS.include?(state.downcase)
        logger.error "state: #{state} is invalid. allowed #{ALLOWED_STATUS}"
        fail Error
      elsif exit_status
        return SUCCESS if exit_status.to_i == 0
        return FAILURE
      else
        logger.error 'require state or exit_state'
        fail Error
      end
    end

    def logger
      ::GithubStatusNotifier.logger
    end
  end
end
