require 'sinatra'
require 'sinatra/reloader' if development?
require 'nokogiri'
require 'typhoeus'
require 'benchmark'

get '/' do
  @list = []
  @result = []
  erb :index, layout: :my_layout 
end

post '/' do
  @list = params[:words].strip.split("\r\n")
  @result = []

    hydra = Typhoeus::Hydra.new
    requests = @list.map do |word|
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
    end

    hydra.run
    result = []
    
    result = requests.map do |r|
      if r.class != Array
        r.response.response_body
      else
        r.map {|r| r.response.response_body}
      end
    end

    result.each do |response|
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
        arr = []
        response.map do |response|
          doc = Nokogiri::HTML(response)

          kk = doc.css('div.compList ul li span.fz-14')

          if kk.empty?
            arr << "沒有 KK 音標"
          elsif not kk.first.content.include?("KK")
            arr << "沒有 KK 音標"
          else
            arr << (kk.first.content.delete 'KK')
          end
        end
        @result << arr
      end
    end
  erb :index, layout: :my_layout
end
