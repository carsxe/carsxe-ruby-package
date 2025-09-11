# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require_relative "types"

module Carsxe
  class CarsXE
    include Types

    def initialize(api_key:)
      @api_key = api_key
    end

    attr_reader :api_key

    def api_base_url
      "https://api.carsxe.com"
    end

    # Public API methods (mirror the python template)
    def specs(params = {})
      get("specs", params, Types::SPECS_INPUT)
    end

    def int_vin_decoder(params = {})
      get("v1/international-vin-decoder", params, Types::VIN_INPUT)
    end

    def recalls(params = {})
      get("v1/recalls", params, Types::VIN_INPUT)
    end

    def plate_decoder(params = {})
      # default country to US if not provided (matches Python template)
      params = params.dup
      params["country"] = "US" if params["country"].nil? || params["country"] == ""
      get("v2/platedecoder", params, Types::PLATE_DECODER_PARAMS)
    end

    def images(params = {})
      get("images", params, Types::IMAGE_INPUT)
    end

    def market_value(params = {})
      # market_value: same required params as VIN_INPUT but 'state' is allowed optional
      required, optional = required_optional(Types::VIN_INPUT, params)
      optional |= ["state"]
      url, query = build_url("v2/marketvalue", params, required, optional)
      perform_get(url, query)
    end

    def history(params = {})
      get("history", params, Types::VIN_INPUT)
    end

    def plate_image_recognition(params = {})
      url = "#{api_base_url}/platerecognition?key=#{api_key}&source=ruby"
      if params.size == 1
        first_key, first_value = params.first
        post_json(url, { first_key => first_value })
      else
        raise ArgumentError, "Expected exactly one parameter, but got #{params.size}"
      end
    end

    def vin_ocr(params = {})
      url = "#{api_base_url}/v1/vinocr?key=#{api_key}&source=ruby"
      if params.size == 1
        first_key, first_value = params.first
        post_json(url, { first_key => first_value })
      else
        raise ArgumentError, "Expected exactly one parameter, but got #{params.size}"
      end
    end

    def year_make_model(params = {})
      get("v1/ymm", params, Types::YEAR_MAKE_MODEL_INPUT)
    end

    def obd_codes_decoder(params = {})
      get("obdcodesdecoder", params, Types::OBDCODESDECODER_INPUT)
    end

    private

    # Determine required and optional keys from a param definition hash.
    # Also applies special plate/country logic:
    # - If country is 'PK' (Pakistan), both 'state' and 'district' are required.
    # - Otherwise ensure 'state' is required for plate decoder (mirrors Python behavior).
    def required_optional(param_def, params = nil)
      required = param_def.select { |_k, v| v == :required }.keys.map(&:to_s)
      optional = param_def.select { |_k, v| v == :optional }.keys.map(&:to_s)

      # Special case for plate decoder params
      if param_def.equal?(Types::PLATE_DECODER_PARAMS)
        country = if params && params["country"]
                    params["country"].to_s.downcase
                  else
                    "us"
                  end

        if country == "pk" || country == "pakistan"
          required |= ["state", "district"]
          optional -= ["state", "district"]
        else
          # ensure 'state' is required for non-PK
          required |= ["state"]
          optional -= ["state"]
        end
      end

      # If params is provided, check all required keys exist and are non-nil
      if params
        missing = required.reject { |k| params.key?(k) && !params[k].nil? }
        unless missing.empty?
          raise ArgumentError, "Missing required parameter(s): #{missing.join(', ')}"
        end
      end

      [required, optional]
    end

    # Build url (string) and query hash for GET requests
    def build_url(endpoint, params, required, optional)
      permitted = (required + optional).map(&:to_s)
      query = {}

      params.each do |k, v|
        key = k.to_s
        next unless permitted.include?(key)
        next if v.nil?

        query[key] = v
      end

      query["key"] = api_key
      query["source"] = "ruby"
      ["#{api_base_url}/#{endpoint}", query]
    end

    # Generic GET path that validates params using the param_def.
    def get(endpoint, params, param_def)
      required, optional = required_optional(param_def, params)
      url, query = build_url(endpoint, params, required, optional)
      perform_get(url, query)
    end

    # Low-level HTTP get helper
    def perform_get(url_str, query = {})
      uri = URI(url_str)
      uri.query = URI.encode_www_form(query) unless query.empty?

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        req = Net::HTTP::Get.new(uri)
        http.request(req)
      end

      parse_response(response)
    end

    def post_json(url_str, payload = {})
      uri = URI(url_str)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req.body = payload.to_json
      response = http.request(req)
      parse_response(response)
    end

    def parse_response(response)
      body = response.body.to_s
      parsed=JSON.parse(body) 
      parsed
    end
  end
end