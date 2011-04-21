=begin
Exemplo que ilustra a criacao de uma classe dentro de um metodo. O metodo podera criar classes diferentes, de acordo com uma regra qualquer e disponibilizar essa classe para heranca de outra padrao externa.
=end

module ClassSample end

module ClassSample::Trick
  
  def self.R(path) # metodo de classe que retorna uma classe
    Class.new {}
  end

  class Edit < R '/edit/(\d+)' #Edit herda da classe retornada por R
    def get(id) end
  end
end


ClassSample::Trick::Edit.new
