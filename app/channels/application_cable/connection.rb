module ApplicationCable
  class Connection < ActionCable::Connection::Base
    after_command :check
    rescue_from StandardError, with: :report_error

    private
      def report_error(e)
        SomeExternalBugtrackingService.notify(e)
      end

      def check
        15.times do
          @p = @p ? @p+1 : 1
          ActionCable.server.broadcast("create_logcontents_progress_channel", { job_id: 1, name: "name", progress: @p, max: 30 })
          sleep(0.2)
        end
      end
  end
end
