require "./spec_helper"

#describe lets you group related specs
#it is used for defining a spec with the give tiitle in between double quotes
#should is used for making assumptions about the spec

describe Blockchain do

  it "false work" do
    false.should eq(false)
  end

  it " true works" do
    true.should eq(true)
  end

  it "shoudnt divide 1 by 3" do
    div_by_three(1).should eq(false)
  end

  it "should divide 3 by 3" do
    div_by_three(3).should eq(true)
  end

  it "shouldnt divide 8 by 5" do
    div_by_five(8).should eq(false)
  end

  it "should divide 5 by 5" do
    div_by_five(5).should eq(true)
  end

  it "shouldnt divide 13 by 15" do
    div_by_fifteen(13).should eq(false)
  end

  it "should divide 15 by 15" do
    div_by_fifteen(15).should eq(true)
  end

end
