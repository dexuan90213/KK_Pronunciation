require 'sinatra'
require 'net/http'
require 'nokogiri'
require 'benchmark'

get '/' do
  "Hello Sinatra"
end

get '/:word' do

  list = Array.new
  result = []
  list.push(params[:word])
  
  sss = Benchmark.measure do
  list.each do |word|

    uri = URI("https://tw.dictionary.search.yahoo.com/search?p=#{word}")

    response = Net::HTTP.get(uri)
    doc = Nokogiri::HTML(response)

    kk = doc.css('div.compList ul li span.fz-14').first.content
    result << (kk.delete 'KK')
  end
  end

  "#{result} ----- #{sss}"

end
