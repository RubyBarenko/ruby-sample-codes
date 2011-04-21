class C
  def greeting(arg)
    puts "C#greeting reveived #{arg}"
  end

  def iterator
    yield 'iterator 1st'
    yield 'iterator 2nd'
    yield 'iterator 3rd'
  end

  local = 1
  def ref_local
    puts local
  end
  
  define_method :ref_local2 do
    puts local
  end
end

obj = C.new

# We can call it normally.
obj.greeting 1     # => C#greeting received 1

# Ruby checks number of arguments.
begin
  obj.greeting 1, 2
rescue => e
  p e
end
  # => ArgumentError: wrong number of arguments (2 for 1)

# Ruby can call a method with a block. Good feature. Pretty good!
obj.iterator do |item|
  puts item
end
  # => iterator 1st
  #    iterator 2nd
  #    iterator 3rd


# We can not access local variables outside of def block.
# In JavaScript, we can. So, not a good feeling.
begin
  obj.ref_local
rescue => e
  p e
end
  # => NameError: undefined local variable or method `local' for #<C:0x5e1b8>

begin
  obj.ref_local2
rescue => e
  p e
ensure # sempre executa isso
  p 'its always happens'
end
  #We can access local variables using define_method because the ruby language
  #only change the context when we use the keywords: class, method, or def.
