require "./spec_helper"

#describe lets you group related specs
#it is used for defining a spec with the give tiitle in between double quotes
#should is used for making assumptions about the spec

describe CheatSheet do

  it "false work" do
    false.should eq(false)
  end

  it " true works" do
    true.should eq(true)
  end
end
