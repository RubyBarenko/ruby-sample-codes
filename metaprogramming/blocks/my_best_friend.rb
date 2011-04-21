=begin
  Ilustra as formas distintas de se chamar um bloco.
  1. obj.instance_eval(&block) => chama o bloco executando seu conteudo no contexto de obj
  2. block.call(arg) => chama o bloco passando arg como parametro 
=end
module Prawn
  class Document
    def self.generate(file, *args, &block)
      pdf = Prawn::Document.new(*args)
      block.arity.zero? ? pdf.instance_eval(&block) : block.call(pdf, *args)
      pdf.render_file(file)
    end
    def render_file(file) puts 'saving in ' << file.to_s; end
    def text(msg) puts msg; end
  end
end

class MyBestFriend
  def initialize
    @first_name = "Paul"
    @last_name = "Mouzas"
  end
  def full_name() "#{@first_name} #{@last_name}"; end
  def generate_pdf
    Prawn::Document.generate("friend.pdf") do |pdf| 
      # como foi passado argumento, chama block.call(pdf), sem alterar o escopo (self == MyBestFriend instance)
      pdf.text "My best friend is #{full_name}"
    end
  end
end

MyBestFriend.new.generate_pdf
