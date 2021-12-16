require "jasper_helpers"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  include Celestite::Adapter::Amber
  #LAYOUT = "application.slang"
end
