class TestBlock
  attr_accessor :var
  def initialize
    @var = 1
  end
  def run(&block)
    instance_eval &block # executa o bloco no escopo da instancia de TestBlock
  end
  def text(t)
    puts t
    puts "the instance @var now is #{@var}"
  end
end

tb = TestBlock.new
tb.run do
  self.var = 2 # como foi usado instance_eval, self = tb, por isso self.var == @var
  text "the var is now #{var}" # => the var is now 2
end
