
module StyleParser
  extend self #insere os metodos do modulo na propria lista de metodos do modulo(para que seja possivel utilizar codigos como StyleParser::process(input) diretamente
  
  SUPPORTED_TAGS = %w{i b}
  TAG_PATTERN = Regexp.new "(</?[#{SUPPORTED_TAGS.join}]>)"
  
  def process(input)
    out = input.split(TAG_PATTERN).reject{|i| i.empty?}
    out.size == 1 ? out.first : out
  end
end


