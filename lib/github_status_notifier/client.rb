module GithubStatusNotifier
  class Client < ::Saddler::Reporter::Github::Client
    def create_status(params)
      state = params.delete(:state)
      logger.info(['create status with these:', slug, @repo.merging_sha, state, params])
      return_state = client.create_status(slug, @repo.merging_sha, state, params)
      logger.debug(return_state)
      return_state
    end

    def logger
      ::GithubStatusNotifier.logger
    end
  end
end
