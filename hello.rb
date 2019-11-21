require 'sinatra'
require 'net/http'
require 'nokogiri'
require 'benchmark'
require 'typhoeus'

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

get '/typhoeus' do
    @list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape)

    @result = []

  @sss = Benchmark.measure do
    hydra = Typhoeus::Hydra.new
    requests = @list.map { |word| 
      request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
      hydra.queue(request) 
      request
    }
    hydra.run
    responses = requests.map { |r| r.response.response_body } 

    
    responses.each do |response|
      doc = Nokogiri::HTML(response)

      kk = doc.css('div.compList ul li span.fz-14').first.content
      @result << (kk.delete 'KK')
    end
  end

    erb :index, layout: :my_layout

end

def ddd
  @sss = Benchmark.measure do
    hydra = Typhoeus::Hydra.new
    @list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape)
    requests = @list.map { |word| 
      request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
      hydra.queue(request) 
      request
    }
    hydra.run
    responses = requests.map { |r| r.response.response_body } 

    @reault = []
    
    responses.each do |response|
      doc = Nokogiri::HTML(response)

      kk = doc.css('div.compList ul li span.fz-14').first.content
      @result << (kk.delete 'KK')
    end
  end
end
