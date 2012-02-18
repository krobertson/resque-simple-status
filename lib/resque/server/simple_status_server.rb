require 'resque' unless defined?(Resque)
require 'resque/server' unless defined?(Resque::Server)

module Resque
  class Worker
    def status
      redis.get("status:#{self}")
    end

    def progress
      (redis.get("status:#{self}:progress") || 0.0).to_f
    end
  end

  module SimpleStatusServer
    def self.registered(app)
      app.get '/statuses' do
        erb(File.read(File.join(File.dirname(__FILE__), 'views', "statuses.erb")))
      end

      app.tabs << "Statuses"
    end
  end
end

Resque::Server.register Resque::SimpleStatusServer
