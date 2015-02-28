module GithubStatusNotifier
  class Notifier
    PENDING = 'pending'
    SUCCESS = 'success'
    ERROR = 'error'
    FAILURE = 'failure'
    ALLOWED_STATUS = [PENDING, SUCCESS, ERROR, FAILURE]
    CONTEXT = 'github_status_notifier'

    def notify(params = {})
      state = decide_state(params[:state], params[:exit_status])
      repo_path = '.'
      repo = Repository.new(repo_path)
      client = Client.new(repo)
      pass_params = {
        target_url: params[:target_url],
        description: params[:description],
        context: decide_context(params[:context])
      }
      client.create_status(state, pass_params)
    rescue StandardError => e
      logger.error e.message
      logger.error e.backtrace
    end

    def decide_target_url(url)
      url || env_target_url
    end

    def env_target_url
      if ENV['TARGET_URL']
        ENV['TARGET_URL']
      elsif ENV['TRAVIS']
        build_travis_target_url
      elsif ENV['CIRCLECI']
        build_circle_target_url
      end
    end

    def build_circle_target_url
      host = ENV['CIRCLE_HOST'] || 'circleci.com'
      link = ENV['CIRCLE_LINK'] || 'gh'
      slug = ENV['CIRCLE_PROJECT_USERNAME'] + '/' + ENV['CIRCLE_PROJECT_REPONAME']
      job_id = ENV['CIRCLE_BUILD_NUM']
      "https://#{host}/#{link}/#{slug}/#{job_id}"
    end

    def build_travis_target_url
      host = ENV['TRAVIS_HOST'] || 'travis-ci.org'
      slug = ENV['TRAVIS_REPO_SLUG']
      job_id = ENV['TRAVIS_JOB_ID']
      "https://#{host}/#{slug}/jobs/#{job_id}"
    end

    def decide_context(text)
      text || CONTEXT
    end

    def decide_state(state, exit_status)
      if state
        return state.downcase if ALLOWED_STATUS.include?(state.downcase)
        fail InvalidStateError, "state: #{state} is invalid. allowed #{ALLOWED_STATUS}"
      elsif exit_status
        return SUCCESS if exit_status.to_i == 0
        return FAILURE
      else
        fail ArgumentError, 'require state or exit-state'
      end
    end

    def logger
      ::GithubStatusNotifier.logger
    end
  end
end
