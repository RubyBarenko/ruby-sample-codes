require "socket"

class Client
  def initialize(ip="127.0.0.1",port=3333)
    @ip, @port = ip, port
  end
  
  def send_message(msg)
    connection do |socket|
      socket.puts(msg)
      socket.gets
    end
  end

  def receive_message
    connection { |socket| socket.gets }
  end
  
  private
  def connection
    socket = TCPSocket.new(@ip,@port)
    yield(socket)
  ensure
    socket.close
  end
end
  
c = Client.new
['hello', 'My name is barenko', 'batatinha', 'goodbye'].each do |msg|
  puts c.send_message msg
end
