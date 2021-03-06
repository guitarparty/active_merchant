require 'digest'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Netgiro
        module ResponseFields
          # orderid
          # confirmationCode
          # invoiceNumber
          # signature    SHA256(SecretKey, OrderId)
          # #name
          # #email
          # #address
          # #address2
          # #city
          # #country
          # #zip


          def complete?
            status == 'Completed'
          end
          alias :success? :complete?

          def item_id
            params['orderid']
          end

          def transaction_id
            params['confirmationCode']
          end

          def invoice_number
            params['invoiceNumber']
          end

          def received_at
            nil
          end

          def customer_name
            params['name']
          end
          
          def customer_address
            params['address']
          end

          def customer_address2
            params['address2']
          end
          
          def customer_zip
            params['zip']
          end
          
          def customer_city
            params['city']
          end
          
          def customer_country
            params['country']
          end
          
          def customer_email
            params['email']
          end


          def currency
            # Netgiro only supports ISK
            'ISK'
          end

          def gross
            # Netgiro does not return the gross
            0
          end

          def status
            "Completed" if acknowledge
          end

          def password
            @options[:credential2]
          end

          def acknowledge
            password ? Digest::SHA256.hexdigest("#{password}#{item_id}") == params['signature'] : true
          end
        end
    	end
    end
	end
end
