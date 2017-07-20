#!/usr/bin/ruby
#require osx & lame

puts "Please input speech text:"
speech_text = gets
puts "input #{speech_text}"

`say -o maked_speech.aiff -v 'Yuna' '#{speech_text}'`
`lame -m m maked_speech.aiff #{Time.now.strftime '%d%H%M%S'}.mp3`
`rm maked_speech.aiff`