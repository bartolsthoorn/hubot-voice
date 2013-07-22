text = ARGV.first

if text.include? 'http'
  `open "#{text}"`
else
  `say #{text}`
end