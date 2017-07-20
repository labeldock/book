#!/usr/bin/ruby

@app_path = 'http://google.co.kr'

@allOpiton = '';
@allOpiton += "--app=#{@app_path}" if @app_path != nil

puts "@allOpiton #{@allOpiton}"

if RUBY_PLATFORM.match 'darwin'
  #OSX
  `/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome #{@allOpiton}`
elsif RUBY_PLATFORM.match 'mingw'
  #Windows
  'windows'
  begin
  	`\"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\" #{@allOpiton}`
  rescue Exception => e
  	begin
  		puts e
  		`\"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe\"  #{@allOpiton}`
  	rescue Exception => e
  		puts e
  	end
  end
elsif RUBY_PLATFORM.match 'linux'
  #Linux
  puts 'linux is not support yet'
else
  #etc
  puts 'unknown os'
end