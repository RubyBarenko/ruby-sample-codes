=begin
  exemplo da diferenca entre include e extend
  include adiciona metodos de instancia
  extend adiciona metodos de instancia de classe
=end
module Secret
  def say_the_secret()
    puts 'its secret'
  end
end

class Joao
  include Secret
end

class Pessoa
  extend Secret
end

Joao.say_the_secret rescue puts 'include adiciona metodo de instancia'
Joao.new.say_the_secret

Pessoa.say_the_secret
Pessoa.new.say_the_secret rescue puts 'extend adiciona metodo de classe'
