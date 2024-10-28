class CreateLogcontentsJob < ApplicationJob
  queue_as :default

    def perform(id)
      extract_and_save_p_elements(id)
    end

    private

    def extract_and_save_p_elements(id)
      pp id
      doc = Nokogiri::HTML(File.open("public/logfile/#{id}.html"))
      log = Log.find(id)

      doc.css("p").each_with_index do |comment_element, index|
        span = comment_element.css("span")
        params = {
          index: index,
          color: comment_element.get_attribute("style").match(/color:\s*([^;]+);?/).to_a[1],
          tab: span[0].text.match(/(?<=\[).+(?=\])/).to_a[0],
          author: span[1].text,
          content: span[2].inner_html.strip
        }
        log_content = log.log_contents.find_by(index: index)
        if log_content.present?
          log_content.update(params)
        else
          log.log_contents.create!(params)
        end
        # ここに終わったときの通知を追加
      end
    end
end
