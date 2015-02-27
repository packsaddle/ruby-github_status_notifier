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

    def notify
      puts 'notify!!'
    end
  end
end
