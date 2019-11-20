require 'sinatra'
require 'net/http'
require 'nokogiri'
require 'benchmark'

get '/' do
  "Hello Sinatra"
end

get '/yahoodictest' do

  list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape scared still dream eye sound future job act actress actor memorize line enough teach reporter interview businessman fisherman try pose age start begin create company become team different perfect popular share keep right library soon until noon hospital stomachache skip important stomach hurt sick rest late tomorrow fever cough headache diary stay junk food tell regular healthy health decide difficult way cold high from now on)
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

  "<h3>單字數量：#{list.count}</h3><br> <p>#{list}</p><br>#{result} ----- #{sss}"

end
