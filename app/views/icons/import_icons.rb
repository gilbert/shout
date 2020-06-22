#
# This is the code used to import icons from https://github.com/refactoringui/heroicons
# It makes icon rendering much more rails-friendly.
# Re-run it on a download of that repo if you need to import new/updated icons.
#
ICON_SOURCES_DIR = nil

splat = '<%= splat_attrs(local_assigns) %>'

Dir["#{ICON_SOURCES_DIR}/{outline,solid}/*"].each do |f|
  basename = File.basename(f)
  color = basename.match(/^md/) ? ' stroke="currentColor" fill="none"' : ' fill="currentColor"'
  new_content = File.read(f)
    .gsub(/ (stroke|fill)="#[^"]*"/, ' \1="currentColor"')
    .sub(/width="[^"]*" /, '')
    .sub(/height="[^"]*" /, '')
    .sub('>', "#{splat}>")
  puts "#{new_content}"
  File.open(f, 'w') do |file|
    puts "Importing #{f}\n#{new_content}"
    file.puts new_content
  end
  File.rename(f, f.sub(basename, "_#{basename.sub(/^(md|sm)-/, '').sub('.svg', '.html.erb')}"))
end
