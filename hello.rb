require 'sinatra'
require 'net/http'
require 'nokogiri'
require 'benchmark'

get '/' do
  "Hello Sinatra"
end

get '/yahoodictest' do

  @list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape)
  @result = []
  
  @sss = Benchmark.measure do
  @list.each do |word|

    uri = URI("https://tw.dictionary.search.yahoo.com/search?p=#{word}")

    response = Net::HTTP.get(uri)
    doc = Nokogiri::HTML(response)

    kk = doc.css('div.compList ul li span.fz-14').first.content
    @result << (kk.delete 'KK')
  end
  end

  erb :index, layout: :my_layout

  # "<h3>單字數量：#{list.count}</h3><br> <p>#{list}</p><br>" + 
    # "<ul><% re</ul>" +  "----- #{sss}"

end
