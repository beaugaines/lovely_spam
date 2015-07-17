require 'net/http'
require 'json'
require_relative 'meats'

SCREEN_WIDTH, SCREEN_HEIGHT = `xrandr`.scan(/current (\d+) x (\d+)/).flatten.map(&:to_i)

def meat_slideshow
  meats_o_the_day = MEATS.split('&')
  puts meats_o_the_day.cycle(99) { |meat| system 'clear'; puts meat; sleep 4 }
end

uri = URI('http://aerial-valor-93012.appspot.com/challenge')
challenge = JSON.parse(Net::HTTP.get(uri)) rescue "that ain't json"

token = challenge['token']
sum = challenge['values'].inject(:+)

success_uri = URI("http://aerial-valor-93012.appspot.com/challenge/#{token}/#{sum}")

success_response = Net::HTTP.get(success_uri)

secret_code = JSON.parse(success_response)['answer']

system 'clear'

puts "#{"\n" * 10}#{secret_code.center(140)} :)"
sleep 4
meat_slideshow

