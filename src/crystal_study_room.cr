# TODO: Write documentation for `CrystalStudyRoom`
#
#Write a program that prints the numbers from 1 to 100. 
#But for multiples of three print "Fizz" instead of the number 
#and for the multiples of five  print "Buzz".
#For numbers which are multiples of both three and five print 
#"FizzBuzz"
#


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


