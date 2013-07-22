require 'coreaudio'
require 'speech'

recording_time = 3 # seconds

dev = CoreAudio.default_input_device
buf = dev.input_buffer(1024)

wav = CoreAudio::AudioFile.new('input.wav', :write, :format => :wav,
                               :rate => dev.nominal_rate,
                               :channels => dev.input_stream.channels)
samples = 0
th = Thread.start do
  loop do
    w = buf.read(4096)
    samples += w.size / dev.input_stream.channels
    wav.write(w)
  end
end

`say "Please speak?"`

buf.start;
$stdout.print "RECORDING..."
$stdout.flush
sleep recording_time;
buf.stop
$stdout.puts "done."
th.kill.join

wav.close

puts "#{samples} samples read."
puts "#{buf.dropped_frame} frame dropped."

audio = Speech::AudioToText.new(File.expand_path(File.join(File.dirname(__FILE__),"/input.wav")))
input_text = audio.to_text

# common errors
input_text = "ping" if input_text.downcase == "pain"
input_text = "ping" if input_text.downcase == "bing"
input_text = "pug me" if input_text.downcase == "#### me" # lol!
input_text = "pug me" if input_text.downcase == "bug me"
input_text = "pug me" if input_text.downcase == "ugh mean"

input_text.gsub!("one", "1")
input_text.gsub!("two", "2")
input_text.gsub!("three", "3")
input_text.gsub!("four", "4")
input_text.gsub!("five", "5")
input_text.gsub!("six", "6")
input_text.gsub!("seven", "7")
input_text.gsub!("eight", "8")
input_text.gsub!("nine", "9")
input_text.gsub!("ten", "10")

puts input_text

File.open('chat.log', 'a') { |file| file.write("#{Time.now} - #{input_text}\n") }

system "./ask \"#{input_text}\""