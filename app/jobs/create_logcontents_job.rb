class CreateLogcontentsJob < ApplicationJob
  queue_as :default

  def perform(user_id, log_id)
    pp "user:#{user_id}"
    pp "log:#{log_id}"
    extract_and_save_p_elements(user_id, log_id)
  end

  # private

  def extract_and_save_p_elements(user_id, log_id)
    doc = Nokogiri::HTML(File.open("public/logfile/#{log_id}.html"))
    log = Log.find(log_id)

    paragraphs = doc.css("p")
    paragraphs.each_with_index do |comment_element, index|
      span = comment_element.css("span")
      params = {
        index: index+1,
        color: comment_element.get_attribute("style").match(/color:\s*([^;]+);?/).to_a[1],
        tab: span[0].text.match(/(?<=\[).+(?=\])/).to_a[0],
        author: span[1].text,
        content: span[2].inner_html.strip
      }
      log_content = log.log_contents.find_by(index: index+1)
      if log_content.present?
        log_content.update(params)
      else
        log.log_contents.create!(params)
      end
      save_notification(user_id, job_id, { name: log.name, progress: index+1, max: paragraphs.size })
      ActionCable.server.broadcast("create_logcontents_progress_channel", { job_id: job_id, name: log.name, progress: index+1, max: paragraphs.size })
    end
    File.delete("public/logfile/#{log_id}.html")
  end

  def save_notification(user_id, job_id, message)
    key = "notifications:user:#{user_id}:job:#{job_id}"
    $redis.mapped_hmset(key, message)   # 通知リストに追加
    $redis.expire(key, 5.days.to_i) # 5日間後に自動削除
  end

  def get_notifications(user_id)
    key = "user:#{user_id}:notifications"
    $redis.lrange(key, 0, -1)  # 全通知を取得
  end
end
