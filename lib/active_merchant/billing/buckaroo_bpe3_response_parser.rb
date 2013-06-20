module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class BuckarooBPE3ResponseParser

      def initialize(response_data, secretkey)
        if response_data.kind_of?(String)
          @response_data = response_data
          @response_params = Rack::Utils.parse_query(response_data)
        elsif response_data.kind_of?(Hash)
          @response_data = ""
          @response_params = response_data
        end
        @signature_valid = ActiveMerchant::Billing::BuckarooBPE3Toolbox.check_signature(@response_params, secretkey)
        # make sure all string keys in hash are downcase
        @response_params = ActiveMerchant::Billing::BuckarooBPE3Toolbox.hash_to_downcase_keys(@response_params)
      end

      def response_data
        @response_data
      end

      def response_params
        @response_params
      end


      def amount
        response_params["brq_amount"]
      end

      def cardnumberending
        response_params["brq_service_mastercard_cardnumberending"] || response_params["brq_service_visa_cardnumberending"]
      end

      def currency
        response_params["brq_currency"]
      end

      def invoicenumber
        response_params["brq_invoicenumber"]
      end

      # Part of the PUSH
      def mutationtype
        response_params["brq_mutationtype"]
      end

      def payment_method
        response_params["brq_payment_method"] || ""
      end

      def redirecturl
        response_params["brq_redirecturl"]
      end

      def signature
        response_params["brq_signature"]
      end

      def statuscode
        response_params["brq_statuscode"]
      end

      def statusmessage
        response_params["brq_statusmessage"]
      end

      def test
        response_params["brq_test"] || ""
      end

      def timestamp
        response_params["brq_timestamp"]
      end

      def transaction_method
        response_params["brq_transaction_method"] || ""
      end

      def transaction_type
        response_params["brq_transaction_type"] || ""
      end

      def transactions
        response_params["brq_transactions"]
      end


      def directdebit?
        # Only for BuckarooBPE3Push, not for BuckarooBPE3Response
        transaction_type.upcase == "C002"
      end

      def directdebitrecurring?
        # Only for BuckarooBPE3Push, not for BuckarooBPE3Response
        transaction_type.upcase == "C003"
      end

      def failure?
        [ "490", "491", "492", "690", "890", "891" ].include?(statuscode)
      end

      def pending?
        [ "790", "791", "792", "793" ].include?(statuscode)
      end

      def reversal?
        # Only for BuckarooBPE3Push, not for BuckarooBPE3Response
        transaction_type.upcase == "C562"
      end

      def signature_valid?
        @signature_valid
      end

      def success?
        statuscode == "190"
      end

      def test?
        test.downcase == "true"
      end

      def valid?
        @signature_valid
      end

    end

  end

end