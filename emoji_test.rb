puts "Hello and welcome to the endless random emoji loop generator!"
puts "Don't say I didn't warn you..."
puts "Pick your poison:\n (a) 🔥\n (b) 🐋 💨\n (c) 🍺\n (d) 🍆\n (e) 💩"
print "> "
response = gets.chomp.downcase

case response
when "a"
  emoji = "🔥"
when "b"
  emoji = "🐋 💨"
when "c"
  emoji = "🍺"
when "d"
  emoji = "🍆"
when "e"
  emoji = "💩"
else
  emoji = "YOU DIDN'T PICK RIGHT"
end

loop_number = rand(1..3)

case loop_number

when 1
  # zig zag
  loop do
    x = 0
    10.times { puts "\t" * x + emoji; x += 1 }
    10.times { puts "\t" * x + emoji; x -= 1 }
  end

when 2
  # matrix
  loop do
    pos = rand(0..10)
    puts "\t" * pos + emoji
  end

when 3
  # crisscross
  loop do
    i, j = 0, 10
    10.times do |x|
      if x < 5
        puts "\t" * i + emoji + "\t" * (j - i) + emoji
        i += 1
        j -= 1
      elsif x == 5
        puts "\t" * 5 + emoji
        i += 1
        j -= 1
      else
      	puts "\t" * j + emoji + "\t" * (i - j) + emoji
        i += 1
        j -= 1
      end
    end
  end

end
