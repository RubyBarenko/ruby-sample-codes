#>> StyleParser.process("Some <b>bold</b> and <i>italic</i> text")
#=> ["Some ", "<b>", "bold", "</b>", " and ", "<i>", "italic", "</i>", " text"]


require 'test/unit'
require './test/testunit_extension'
require './inline_style_parsing'

class TestInlineStyleParsing < Test::Unit::TestCase
	
	must 'be return same string without tags' do
		assert StyleParser.process("Some text here").must_be "Some text here"
	end
	
	must 'be return italic parse if italic tag' do
		assert StyleParser.process("Some <i>italic</i> text here")
    .must_be ["Some ", "<i>", "italic", "</i>", " text here"]
	end

	must 'be return bold parse if bold tag' do
		assert StyleParser.process("Some <b>bold</b> text here")
    .must_be ["Some ", "<b>", "bold", "</b>", " text here"]
	end

	must 'be return bold and italic parse if bold or italic tag' do
		assert StyleParser.process("Some <b>bold</b> and <i>italic</i> text")
    .must_be ["Some ", "<b>", "bold", "</b>", " and ", "<i>", "italic", "</i>", " text"]
	end

	must 'be return bold and italic parse if bold inside italic tag' do
		assert StyleParser.process("This is a string with <b>bold, <i>bold italic</i></b> and <i>italic</i> text")
    .must_be ["This is a string with ", "<b>", "bold, ", "<i>", "bold italic", "</i>", "</b>", " and ", "<i>", "italic", "</i>", " text"]
	end
end
