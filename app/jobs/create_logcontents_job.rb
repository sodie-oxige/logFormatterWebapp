class CreateLogcontentsJob < ApplicationJob
  queue_as :default

  def perform(user_id, log_id)
    pp "user:#{user_id}"
    pp "log:#{log_id}"
    extract_and_save_p_elements(user_id, log_id)
  end

  private

  def extract_and_save_p_elements(user_id, log_id)
    user = User.find(user_id)
    doc = Nokogiri::HTML(File.open("public/logfile/#{log_id}.html"))
    log = Log.preload(:log_contents).find(log_id)

    @percent = 0
    paragraphs = doc.css("p")
    notion = user.notions.new({ job_id: job_id, name: "#{log.name}", progress: 0, max: paragraphs.size })
    notion.save
    paragraphs.each_with_index do |comment_element, index|
      span = comment_element.css("span")
      params = {
        index: index+1,
        color: comment_element.get_attribute("style").match(/color:\s*([^;]+);?/).to_a[1],
        tab: span[0].text.match(/(?<=\[).+(?=\])/).to_a[0],
        author: span[1].text,
        content: span[2].inner_html.strip
      }
      log_content = log.log_contents.find { |lc| lc.index == index + 1 }
      if log_content.present?
        log_content.update(params)
      else
        log.log_contents.create!(params)
      end
      if @percent < ((index+1)*100).div(paragraphs.size)
        @percent = ((index+1)*100).div(paragraphs.size)
        hash = { job_id: job_id, name: "#{log.name}", progress: index+1, max: paragraphs.size }
        pp notion
        notion.update(hash)
        ActionCable.server.broadcast("create_logcontents_progress_channel", hash)
      end
  end
    hash = { job_id: job_id, name: "#{log.name}", progress: paragraphs.size, max: paragraphs.size }
    notion.update(hash)
    ActionCable.server.broadcast("create_logcontents_progress_channel", hash)
    File.delete("public/logfile/#{log_id}.html")
  end
end
