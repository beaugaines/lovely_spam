require 'net/http'
require 'json'
require_relative 'meats'

def meat_slideshow
  meats_o_the_day = MEATS.split('&')
  puts meats_o_the_day.cycle(99) { |meat| system 'clear'; puts meat; sleep 4 }
end

uri = URI('http://aerial-valor-93012.appspot.com/challenge')
json_response = JSON.parse(Net::HTTP.get(uri)) rescue "that ain't json"

token = json_response['token']
sum = json_response['values'].inject(:+)

success_uri = URI("http://aerial-valor-93012.appspot.com/challenge/#{token}/#{sum}")
success_response = JSON.parse(Net::HTTP.get(success_uri)) rescue "that is nae json"

system 'clear'

puts "#{"\n" * 10}#{success_response['answer'].center(140)} :)"
sleep 4
meat_slideshow

