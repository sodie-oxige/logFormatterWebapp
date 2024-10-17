Rails.application.config.dartsass.builds = Hash[
  Dir.glob("app/assets/stylesheets/*.scss").map do |path|
    # SCSSファイルをパスから抽出してビルド設定を作成
    scss_path = path.sub("app/assets/stylesheets/", "")
    css_path = scss_path.sub(".scss", ".css")
    [ scss_path, css_path ]
  end.to_h
]
