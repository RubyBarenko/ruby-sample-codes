
module Test::Unit
	class TestCase
		def self.must(name, &block)
			test_method_name = "test_must_#{name.gsub(/ +/,'_')}".to_sym
			defined = instance_method(test_method_name) rescue false
			
			raise "#{test_method_name} is already defined in #{self}" if defined
			
			if block_given?
				define_method test_method_name, &block
			else
				define_method test_method_name do
					flunk "No implementation provided for #{name}"
				end
			end
		end
	end
end


class Object
	def must_be(value)
		(self == value or self.eql?(value) or self.equal?(value))
	end
	
	alias_method :must_be_equal, :must_be
end
