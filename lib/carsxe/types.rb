# frozen_string_literal: true
#
# Parameter "schemas" used by the client to determine required vs optional keys.
# Values are :required or :optional (simple representation, enough for validation here).

module Carsxe
  module Types
    VIN_INPUT = {
      "vin" => :required
    }.freeze

    PLATE_DECODER_PARAMS = {
      "plate"    => :required,
      "country"  => :optional, # country is allowed but not strictly required by default
      "state"    => :optional,
      "district" => :optional
    }.freeze

    IMAGE_INPUT = {
      "make"        => :required,
      "model"       => :required,
      "year"        => :optional,
      "trim"        => :optional,
      "color"       => :optional,
      "transparent" => :optional,
      "angle"       => :optional,
      "photoType"   => :optional,
      "size"        => :optional,
      "license"     => :optional
    }.freeze

    OBDCODESDECODER_INPUT = {
      "code" => :required
    }.freeze

    PLATE_IMAGE_RECOGNITION_INPUT = {
      "upload_url" => :required
    }.freeze

    VIN_OCR_INPUT = {
      "upload_url" => :required
    }.freeze

    YEAR_MAKE_MODEL_INPUT = {
      "year"  => :required,
      "make"  => :required,
      "model" => :required,
      "trim"  => :optional
    }.freeze

    SPECS_INPUT = {
      "vin"                     => :required,
      "deepData"                => :optional,
      "disableIntVINDecoding"   => :optional
    }.freeze
  end
end