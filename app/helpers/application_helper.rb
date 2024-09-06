module ApplicationHelper
  def first_visit?
    referer = request.referer
    if referer.nil?
      true
    else
      referer_uri = URI.parse(referer)
      referer_host_with_port = "#{referer_uri.host}:#{referer_uri.port}"
      current_host_with_port = request.host_with_port
      referer_host_with_port != current_host_with_port
    end
  end
end
