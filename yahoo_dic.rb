# require('open-uri')
# require('nokogiri')
#
# def dic(list)
#   result = []
#   list.each do |uri|
#     doc = open("https://tw.dictionary.yahoo.com/dictionary?p=#{uri}")
#     html = doc.read
#     parsed_content = Nokogiri::HTML(html)
#     if parsed_content.css('.grp-main').empty?
#       result << ""
#     else
#       kk = parsed_content.css('.grp-main').css('.compList').css('.fz-14').first.inner_text
#       result << kk
#     end
#   end
#   result
# end
#
# list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape scared still dream eye sound future job act actress actor memorize line enough teach reporter interview businessman fisherman try pose age start begin create company become team different perfect popular share keep right library soon until noon hospital stomachache skip important stomach hurt sick rest late tomorrow fever cough headache diary stay junk food tell regular healthy health decide difficult way cold high from now on)
#
# p dic(list)
# 
#
#

require 'net/http'
require 'nokogiri'
require 'benchmark'

# uri = URI("https://tw.dictionary.search.yahoo.com/search?p=hello")
#
# response = Net::HTTP.get(uri)
# doc = Nokogiri::HTML(response)
#
# puts "---------------------------"
# kk = doc.css('div.compList ul li span.fz-14')
#
#
list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape scared still dream eye sound future job act actress actor memorize line enough teach reporter interview businessman fisherman try pose age start begin create company become team different perfect popular share keep right library soon until noon hospital stomachache skip important stomach hurt sick rest late tomorrow fever cough headache diary stay junk food tell regular healthy health decide difficult way cold high from now on)

puts "Word count : #{list.count}"

result = []

sss = Benchmark.measure do
list.each do |word|

  uri = URI("https://tw.dictionary.search.yahoo.com/search?p=#{word}")

  response = Net::HTTP.get(uri)
  doc = Nokogiri::HTML(response)

  kk = doc.css('div.compList ul li span.fz-14').first.content
  result << (kk.delete 'KK')
end
end

p list
puts "---------------"
p result

puts sss
