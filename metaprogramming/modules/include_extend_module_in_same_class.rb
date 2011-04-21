=begin
  exemplo de inclusao automatica de extend ao usar include. 
  Esse exemplo exibe o codigo convencional e em seguida utiliza o método included que é chamado sempre que o modulo secret2 for incluido em alguma classe. o uso do extend é feito dentro do included.
=end
module Secret
  def secret() puts 'its secret' end
end

class Person
  include Secret
  extend Secret
end

Person.secret
Person.new.secret

#OR

module Secret2
  def secret() puts 'its secret' end
  def self.included(base) base.extend Secret2 end
end

class Person2
  include Secret2
end

Person2.secret
Person2.new.secret
