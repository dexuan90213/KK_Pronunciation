def aaa(ws)
ws = ws.split("\r\n")
ws.map do |w|
    if w.include?(" ")
    w.split(" ")
    else
    w
    end
  end
end

list =  aaa("video\r\nsecurity camera\r\nfind\r\nhoney\r\nstop\r\nhalf\r\ntake it easy\r\njust\r\ndo the dishes \r\nquarter\r\n")

def ss(list)
  list.each do |l|
    if l.class != Array
      p l
    else
      ss(l)
    end
  end
end

ss(list)

