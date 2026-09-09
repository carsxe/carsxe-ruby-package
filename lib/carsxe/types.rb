# frozen_string_literal: true
#
# Parameter "schemas" used by the client to determine required vs optional keys.
# Values are :required or :optional (simple representation, enough for validation here).

module Carsxe
  module Types
    VIN_INPUT = {
      "vin" => :required
    }.freeze

    MARKET_VALUE_INPUT = {
      "vin"       => :required,
      "state"     => :optional,
      "mileage"   => :optional,
      "condition" => :optional
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

    RECALLS_YMM_INPUT = {
      "year"  => :required,
      "make"  => :required,
      "model" => :required
    }.freeze

    RECALLS_BATCH_INPUT = {
      "batchId" => :required
    }.freeze

    YMM_OPTIONS_INPUT = {
      "dimension" => :optional,
      "year"      => :optional,
      "make"      => :optional,
      "model"     => :optional,
      "trim"      => :optional
    }.freeze

    OWNERSHIP_VIN_INPUT = {
      "vin"     => :required,
      "include" => :optional
    }.freeze

    OWNERSHIP_PERSON_INPUT = {
      "first_name" => :required,
      "last_name"  => :required,
      "address"    => :required,
      "zip"        => :required,
      "include"    => :optional
    }.freeze

    OWNERSHIP_ADDRESS_INPUT = {
      "address" => :required,
      "zip"     => :required,
      "include" => :optional,
      "variant" => :optional
    }.freeze

    OWNERSHIP_ZIP_INPUT = {
      "zip"     => :required,
      "gender"  => :optional,
      "min_age" => :optional,
      "max_age" => :optional,
      "income"  => :optional,
      "page"    => :optional,
      "limit"   => :optional,
      "include" => :optional,
      "variant" => :optional
    }.freeze

    US_PLATE_DECODER_INPUT = {
      "plate"     => :required,
      "state"     => :required,
      "decodeVIN" => :optional
    }.freeze
  end
end