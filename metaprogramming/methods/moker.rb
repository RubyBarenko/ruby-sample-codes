=begin
cria um mock de um determinado objeto de instancia.
Exemplo de uso, vide test_moker.rb
=end
class Moker
  def initialize(instance, methods={}, &block)
    @instance = instance
    @methods = {}
    
    should_receive(methods, &block)
  end
  
  def should_receive( methods = {}, &block)
    @methods.merge! methods
    
    if block_given? then
      moker_method = MokerMethod.new
      block.call(moker_method)
      @methods.merge! moker_method.methods
    end
    
    moker_method
  end
  
  def method_missing(method, *args, &block)
    return @methods[method] if @methods.has_key?(method)
    @instance.send(method,*args, &block)
  end
end

class Moker::MokerMethod
  attr_reader :methods 

  def mock(name, return_value)
    @methods ||= {}
    @methods[name] = return_value
  end
end


module Kernel
  def moker(instance, methods={}, &block)
    Moker.new(instance, methods, &block)
  end
end
