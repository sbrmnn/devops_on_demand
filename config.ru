# This file is used by Rack-based servers to start the application.

require 'honeycomb-beeline'

Honeycomb.init(
    writekey: "0271156dccfc88cb2eb04cf05ba25a45",
    dataset: "DevOpsOnDemand"
)

require_relative 'config/environment'

run Rails.application

