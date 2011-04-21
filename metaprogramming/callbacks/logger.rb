require 'test/unit'
require 'tempfile'

module Logger

  def self.included(base)
    base.extend(Logger)
  end

  attr_accessor :log_io
 
  def method_added(new_method_name)
    @_logged_methods_by_logger ||= []
    return if new_method_name =~ /^_logged_/ || @_logged_methods_by_logger.include?(new_method_name)
    
    @_logged_methods_by_logger << new_method_name

    logged_method_name = "_logged_#{new_method_name}".to_sym

    send(:alias_method, logged_method_name, new_method_name)

    send(:define_method, new_method_name) do |*args, &block|
      @log_io ||= $stdout
      @log_io.puts "calling #{self.class}.#{new_method_name}(#{args.inspect[1..-2]}) #{block}..."
      return_value = nil
      begin
        return_value = send(logged_method_name, *args, &block) 
      rescue Exception => e 
        @log_io.puts "Error: #{e}"
        raise e
      end
      @log_io.puts "Return of #{self.class}.#{new_method_name}(): #{return_value || 'nil'}"
      return_value
    end
  end
end

#to tests....

class Person
  include Logger
  def walk() puts 'walking' end
  def say(*somethings) puts "say: #{somethings ||= 'nothing'}" end
  def specie() 'Homo Sapiens' end
  def make(&block) block.call('making ') end
end

class TestLogger < Test::Unit::TestCase
  def setup() 
    @tmp = Tempfile.new('tst-logger-')
    @person = Person.new
    @person.log_io = @tmp
  end
  
  def test_must_return_call_and_return_nil()
    @person.walk

    asserts "calling Person.walk() ...\n", "Return of Person.walk(): nil\n"
  end
  
  def test_must_return_call_and_parameter_and_return_nil()
    @person.say 'blah'

    asserts "calling Person.say(\"blah\") ...\n", "Return of Person.say(): nil\n"
  end

  def test_must_return_call_and_none_parameter_and_return_nil()
    @person.say

    asserts "calling Person.say() ...\n", "Return of Person.say(): nil\n"
  end
  
  def test_must_return_call_and_return_msg()
    @person.specie

    asserts "calling Person.specie() ...\n", "Return of Person.specie(): Homo Sapiens\n"
  end
  
  def test_must_return_call_and_return_msg()
    @person.make {|x| puts x << 'home'}

    asserts( /calling Person.make\(\) #<Proc:0x[0-9a-f]{7}@logger.rb:[0-9]+>\.\.\.\n/, "Return of Person.make(): nil\n")
  end
  
  private
  
  def asserts(*args)
    tmp = output(@tmp)
    assert_equal(args.size, tmp.size)
    args.size.times do |i|
      args[i].class == Regexp ? assert_match(args[i], tmp[i]) : assert_equal(args[i], tmp[i])
    end
  end
  
  def output(io)
    io.flush
    IO.readlines(io.path)
  end
end


