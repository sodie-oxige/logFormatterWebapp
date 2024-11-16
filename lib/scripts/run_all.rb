module Scripts
  class RunAll
    def self.run
      scripts = Dir[Rails.root.join("lib/scripts/*.rb")]
      scripts.reject! { |script| script.end_with?("run_all.rb") }

      if scripts.empty?
        puts "実行するスクリプトはありません"
      else
        scripts.each do |script|
          puts "実行中: #{script}"
          require script
        end
      end
    end
  end
end
