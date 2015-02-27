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
    def notify
      abort('keep-exit-status requires exit-status') if options[:keep_exit_status] && !options[:exit_status]
      puts 'notify!!'
      if options[:keep_exit_status]
        exit options[:exit_status]
      end
    end
  end
end
