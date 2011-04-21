=begin
Exemplo de uso de uma super classe que super que esconde a maioria de seus metodos para que seja possivel criar um objeto "em branco", sem os metodos de Object.
=end
class BlankSlate
  def self.hide(method_name)
    @methods ||= {}
    if instance_methods.include?(method_name) and method_name !~ /^(__|instance_eval)/
      @methods[method_name] = instance_method(method_name)
      undef_method(method_name)
    end
  end
  
  def self.find_hidden_method(method_name)
    @methods ||= {}
    @methods[method_name] || superclass.find_hidden_method(method_name)
  end
  
  def self.reveal(method_name)
    unbound_method = find_hidden_method method_name
    fail "Don't known how to reveal method '#{method_name}'" unless unbound_method
    define_method(method_name, unbound_method)
  end

  instance_methods.each {|m| hide m }
end


class A < BlankSlate
end


p 1
p A.new rescue 'undef 1'
p 2
A.reveal(:inspect)
p 3
A.reveal(:to_s)
p 4
p A.new

p 5
p A.new.to_s
p 6
A.hide(:to_s)
p 7
A.new.to_s rescue p 'A.new.to_s: method not found'
