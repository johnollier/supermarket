puts "Welcome to the GDS supermarket"

finish = false

while !finish
  puts "Please enter command"
  command = gets
  if command == 'checkout':
    finish = true
  end

end