=begin
  Executa o run de todas as classes que herdaram BasicTest.
  Para isso, utiliza o inherited, que é chamado automaticamente sempre que alguma classe herdar BasicTest.
=end
class BasicTest
  def self.inherited(base)
    tests << base
  end
  
  def self.tests
    @tests ||=[]
  end
  
  def self.run
    tests.each do |t|
      t.instance_methods.grep(/^test_/).each do |m|
        test_case = t.new
        test_case.setup if test_case.respond_to?(:setup)
        test_case.send(m)
      end
    end
  end
end

class ATest < BasicTest
  def test_a()
    puts 'test a'
  end
end

class BTest < BasicTest
  def test_b()
    puts 'test b'
  end
end

BasicTest.run
