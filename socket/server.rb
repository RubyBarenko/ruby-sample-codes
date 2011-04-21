require 'socket'

class Server
  def initialize(port=3333)
    @port = port
  end
  
  def handle(regexp, &block)
    @handlers ||= {}
    @handlers[regexp] = block
  end
  
  def run
    server = TCPServer.open(@port)
    loop do
      client = server.accept
      msg = client.gets
      unknown_msg = false
      @handlers.each do |k,v|
        break client.puts(v.call msg) if unknown_msg = k =~ msg
      end
      
      client.puts("Message Unknown: #{msg}") unless unknown_msg
      
      client.close
    end
  end
  
  def Server.run(&block)
    server = Server.new
    server.instance_eval(&block) if block_given?
    server.run
  end
end

=begin
server = Server.new
server.handle(/hello/i) { "Hello from server at #{Time.now}" }
server.handle(/goodbye/i) { "Goodbye from server at #{Time.now}" }
server.handle(/name is (\w+)/) { |m| "Nice to meet you #{m}!" }
server.run
=end

Server.run do 
  handle(/hello/i) { "Hello from server at #{Time.now}" }
  handle(/goodbye/i) { "Goodbye from server at #{Time.now}" }
  handle(/name is (\w+)/) { |m| "Nice to meet you #{m}!" }
end
