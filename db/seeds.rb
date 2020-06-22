ActiveRecord::Base.transaction do
  words_file = File.read File.join(Rails.root, 'lib/word_list.txt')

  count = 0
  words_file.lines.each do |word|
    UrlWord.create :word => word.strip, :expires_at => DateTime.now
    count += 1
    # IO is slow, so only puts this every 100 words
    puts "Seeded #{count} words so far..." if count % 100 == 0
  end
end
