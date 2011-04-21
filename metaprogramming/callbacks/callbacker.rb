=begin
Exemplo de metodos que sáo chamados automaticamente em eventos de alteraçao de classes.
=end

module Callbacker end

module Callbacker::Helper
  def self.object_name(obj)
     "#{obj}##{obj.object_id}"
  end
  def self.mask(msg, obj)
    "Callbacker: #{msg}.".gsub('#obj',self.object_name(obj))
  end
  def self.puts(msg, obj=nil)
    Kernel::puts self.mask msg, obj
  end
end

module Callbacker
  extend Callbacker::Helper
  
  def method_removed(method)
    Helper::puts("The #{method} method has removed from #obj", self)
  end
  
  def method_undefined(method)
    Helper::puts "The #{method} method has undefined to #obj", self
  end
  
  def append_features(module_name)
    Helper::puts "The Callbacker has appended into #{module_name}", self
  end
  
  def const_missing(sym)
    Helper::puts "The #{sym} is missing into #obj", self
  end
  
  def included(name)
    Helper::puts "The Callbacker has included by #{name}", self
  end

  def extended(name)
    Helper::puts "The Callbacker has extended by #{name}", self
  end

  def inherited(base)
    Helper::puts "The #obj has inherited by #{base}", self
  end

  def method_added(method)
    Helper::puts "The #{method} method has added into #obj", self
  end
end

class MyObjects
  extend Callbacker
  
  def initialize() end
  def my_method() end
  def my_another_method() end
  
  undef_method :my_method
  remove_method :my_another_method
end
