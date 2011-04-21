
require 'test/unit'
require 'testunit_extension'
require 'moker'

class TestMoker < Test::Unit::TestCase
  class People
    attr_reader :fullname, :age
    def initialize(fullname, age) @fullname, @age = fullname, age; end;
    def first_name() @fullname.split.first; end;
    def last_name() @fullname.split.last; end;
  end

  def setup
    @people = People.new('Rafael Caetano Pinto', 28)
  end
  
  def teardown
    @people = nil
  end
  
  must 'mock a People class by hash' do
    mokered = moker(@people, :last_name => 'barenko', :first_name=> 'Sr.')
    
    assert mokered.last_name.must_be 'barenko' 
    assert mokered.first_name.must_be 'Sr.' 
    assert mokered.fullname.must_be 'Rafael Caetano Pinto'
    assert mokered.age.must_be 28 
  end

  must 'mock a People class by block' do
    mokered = moker(@people) do |method|
      method.mock :first_name, 'Sr.'
      method.mock :last_name, 'barenko'
    end

    assert mokered.last_name.must_be 'barenko' 
    assert mokered.first_name.must_be 'Sr.' 
    assert mokered.fullname.must_be 'Rafael Caetano Pinto'
    assert mokered.age.must_be 28 
  end
  
  must 'redefine a method return' do
    mokered = moker(@people)
    assert mokered.first_name.must_be 'Rafael'
    mokered.should_receive(:first_name => 'barenko')
    assert mokered.first_name.must_be 'barenko'
  end
end
