require 'resque' unless defined?(Resque)
require 'resque-access_worker_from_job' unless defined?(Resque::Plugins::AccessWorkerFromJob)

module Resque # :nodoc:
  module Plugins # :nodoc:
    module SimpleStatus
      def self.extended(base)
       unless base.methods.include?('perform') || base.methods.include?(:perform)
          raise %Q{You must call "extend Resque::Plugins::SimpleStatus" AFTER (below) defining the perform method}
        end
       base.extend(Resque::Plugins::AccessWorkerFromJob)
      end

      def set_message(message)
        worker.redis.set("status:#{worker}", message)
      end

      def set_progress(count, total=nil)
        percent = count.to_f
        percent = percent / total if total
        worker.redis.set("status:#{worker}:progress", percent.to_s)
      end

      def after_perform_cleanup_status(*args)
        worker.redis.del("status:#{worker}")
        worker.redis.del("status:#{worker}:progress")
      end
    end
  end
end
