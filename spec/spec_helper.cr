require "spec"
require "../src/crystal_study_room"

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


