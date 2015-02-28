module GithubStatusNotifier
  class Notifier
    PENDING = 'pending'
    SUCCESS = 'success'
    ERROR = 'error'
    FAILURE = 'failure'
    ALLOWED_STATUS = [PENDING, SUCCESS, ERROR, FAILURE]

    def notify(params)
      state = determine_state(params[:state], params[:exit_status])
      repo_path = '.'
      repo = Repository.new(repo_path)
      client = Client.new(repo)
      pass_params = {
        target_url: params[:target_url],
        description: params[:description],
        context: params[:context]
      }
      client.create_status(state, pass_params)
    rescue StandardError => e
      logger.error e.message
      logger.error e.backtrace
      client.create_status(ERROR, pass_params)
    end

    def determine_state(state, exit_status)
      if state
        return state.downcase if ALLOWED_STATUS.include?(state.downcase)
        fail Error("state: #{state} is invalid. allowed #{ALLOWED_STATUS}")
      elsif exit_status
        return SUCCESS if exit_status.to_i == 0
        return FAILURE
      else
        fail Error('require state or exit_state')
      end
    end

    def logger
      ::GithubStatusNotifier.logger
    end
  end
end
