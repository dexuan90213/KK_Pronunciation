require 'sinatra'
require 'sinatra/reloader' if development?
require 'nokogiri'
require 'typhoeus'
require 'benchmark'

get '/' do
    @list = []
    @result = []
    erb :search, layout: :my_layout 
  end

post '/' do
  @list = params[:words].strip.split("\r\n")
  # return "#{params}"
  @result = []

  @sss = Benchmark.measure do
    hydra = Typhoeus::Hydra.new
    requests = @list.map { |word|
      if word.include?(" ")
        word.split(" ").map do |word|
          request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
          hydra.queue(request)
          request
        end
      else
        request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
        hydra.queue(request)
        request
      end
    }

    hydra.run
    rrr = []
    
    rrr = requests.map do |r|
      if r.class != Array
        r.response.response_body
      else
        r.map {|r| r.response.response_body}
      end
    end

    # return "#{rrr}"

    rrr.each do |response|
      if response.class != Array
        doc = Nokogiri::HTML(response)

        kk = doc.css('div.compList ul li span.fz-14')

        if kk.empty?
          @result << "沒有 KK 音標"
        elsif not kk.first.content.include?("KK")
          @result << "沒有 KK 音標"
        else
          @result << (kk.first.content.delete 'KK')
        end
      else
        rrr = []
        response.map do |response|
          doc = Nokogiri::HTML(response)

          kk = doc.css('div.compList ul li span.fz-14')

          if kk.empty?
            rrr << "沒有 KK 音標"
          elsif not kk.first.content.include?("KK")
            rrr << "沒有 KK 音標"
          else
            rrr << (kk.first.content.delete 'KK')
          end
        end
        @result << rrr
      end
    end
  end
    erb :search, layout: :my_layout

end

get '/search' do
  erb :index, layout: :my_layout
end

post '/search' do
  @list = params[:words].strip.split("\r\n")
  # return "#{params}"
  @result = []

  @sss = Benchmark.measure do
    hydra = Typhoeus::Hydra.new
    requests = @list.map { |word|
      if word.include?(" ")
        word.split(" ").map do |word|
          request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
          hydra.queue(request)
          request
        end
      else
        request = Typhoeus::Request.new("https://tw.dictionary.search.yahoo.com/search?p=#{word}", followlocation: true)
        hydra.queue(request)
        request
      end
    }

    hydra.run
    rrr = []
    
    rrr = requests.map do |r|
      if r.class != Array
        r.response.response_body
      else
        r.map {|r| r.response.response_body}
      end
    end

    # return "#{rrr}"

    rrr.each do |response|
      if response.class != Array
        doc = Nokogiri::HTML(response)

        kk = doc.css('div.compList ul li span.fz-14')

        if kk.empty?
          @result << "沒有 KK 音標"
        elsif not kk.first.content.include?("KK")
          @result << "沒有 KK 音標"
        else
          @result << (kk.first.content.delete 'KK')
        end
      else
        rrr = []
        response.map do |response|
          doc = Nokogiri::HTML(response)

          kk = doc.css('div.compList ul li span.fz-14')

          if kk.empty?
            rrr << "沒有 KK 音標"
          elsif not kk.first.content.include?("KK")
            rrr << "沒有 KK 音標"
          else
            rrr << (kk.first.content.delete 'KK')
          end
        end
        @result << rrr
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
