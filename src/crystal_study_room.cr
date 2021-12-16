# TODO: Write documentation for `CrystalStudyRoom`


######################################
#M4cr05 and Metaprogramming
#Macros are code that writes/modifies code

macro define_method(name, content)
  def {{name}}
    {{content}}
  end
end

define_method foo, 1

######################################
#M3thod Ov3rloading
def add(x : Number, y : Number)
  x + y
end

def add(x : Number, y : String)
  x.to_s + y
end
#######################################
#C0ncurr3cy and Ch4nn3l5

channel = Channel(String).new
spawn {
  channel.send "Whats good Shawty?"
}
puts "About to recieve message from channel"
puts channel.receive
#######################################
#
#Write a program that prints the numbers from 1 to 100.
#But for multiples of three print "Fizz" instead of the number
#and for the multiples of five  print "Buzz".
#For numbers which are multiples of both three and five print
#"FizzBuzz"
########################################

def div_by_three(n)

  if n % 3 == 0
    true
  else
    false
  end

end

def div_by_five(n)
  n % 5 == 0
end

def div_by_fifteen(n)
  n % 15 == 0
end

(1..100).each do |num|
  answer = if div_by_fifteen num
    "FizzBuzz"
  elsif div_by_three num
    "Fizz"
  elsif div_by_five num
    "Buzz"
  else
    num
  end

  puts answer

end

puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

puts add 3, 5
puts add 3, "Boiiii"
