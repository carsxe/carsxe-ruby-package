# frozen_string_literal: true

require_relative "carsxe/version"
require_relative "carsxe/carsxe"

module Carsxe
  carsxe = Carsxe::CarsXE.new(api_key: "your_api_key_here")
  data = carsxe.specs("vin" => "WBAFR7C57CC811957")
  begin
    puts data
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end