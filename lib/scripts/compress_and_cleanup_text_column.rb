module Scripts
  class CompressAndCleanupTextColumn
    def self.run
      puts "------- ------- ------- ------- "
      puts "データ移行を開始します！"

      # Step 1: 圧縮してコピー
      Character.find_each do |character|
        next if character.text.blank?

        # textカラムからcompressed_textカラムにデータを圧縮してコピー
        character.update!(compressed_text: Zlib::Deflate.deflate(character.text))
      end

      puts "圧縮完了！"
      puts "------- ------- ------- ------- "
    end
  end
end

# 実行
Scripts::CompressAndCleanupTextColumn.run
