require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'nokogiri'
require 'benchmark'
require 'typhoeus'

# get '/' do
#   "Hello Sinatra"
# end

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



get '/w86' do

 @list =  %w(video find honey stop half just quarter lie sleepwalk housework sweep mop  wipe window  mat someone laugh move body shape scared still dream eye sound future job act actress actor memorize line enough teach reporter interview businessman fisherman try pose age start begin create company become team different perfect popular share keep right library soon until noon hospital stomachache skip important stomach hurt sick rest late tomorrow fever cough headache diary stay junk food tell regular healthy health decide difficult way cold high from now on)
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

get '/' do
    @list = []
    @result = []
    erb :search, layout: :my_layout 
  end

post '/' do
  @list = params[:words].strip.split("\r\n")
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

      kk = doc.css('div.compList ul li span.fz-14')

      if kk.empty? 
        @result << "沒有 KK 音標"
      elsif not kk.first.content.include?("KK")
        @result << "沒有 KK 音標"
      else
        @result << (kk.first.content.delete 'KK')
      end
    end
  end

    erb :search, layout: :my_layout

end

get '/search' do
  erb :index, layout: :my_layout
end

post '/search' do
  return "#{params}"
  @list = params[:words].strip.split("\r\n")
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

      kk = doc.css('div.compList ul li span.fz-14')

      if kk.empty?
        @result << "沒有 KK 音標"
      elsif not kk.first.content.include?("KK")
        @result << "沒有 KK 音標"
      else
        @result << (kk.first.content.delete 'KK')
      end
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
